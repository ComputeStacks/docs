---
title: Building Images
description: Best practices for building container images for ComputeStacks
---
# Building Images for ComputeStacks

## Before you start

### Docker Installation

These examples require that you have access to a local installation of Docker.

??? question "How do I install docker?"
    If you don't already have it installed, you can install it from:
    
    - [Download Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
    - [Download Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)
    - Download Docker for Linux:
        - [Docker for Centos](https://docs.docker.com/install/linux/docker-ce/centos/)
        - [Docker for Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
        - [Docker for Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)
        - [Docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

### Understand Container Registries

The first step in building your docker container is choosing a place to store your image. This is how ComputeStacks will access the finished image and deploy it on the cluster.

You can use popular options like [Docker Hub](https://hub.docker.com){: target="_blank" }, [GitHub](https://github.com){: target="_blank" }, or [Gitlab](https://about.gitlab.com){: target="_blank" }, or you can use the built-in Container Registry that's included with ComputeStacks.

To use ComputeStacks, login to your account and navigate to *Container Registry*. Click 'New Registry' if you don't already have one and give it a friendly name. 

A container registry can hold an unlimited number of images, so you only need one. However, if you're working with multiple people, you may want to create a registry per-project so you can selectively give access to the developers who need to push images. 

Once your registry is created, make note of the *registry url* and the *username*, and *password.*

On your local instance of docker, open a command prompt and enter `docker login <registry-url>`.

### Make use of our Metadata service
When building multi-container services, you can leverage our [Metadata service](`/user_guide/developer-tools/#metadata-service`) to automate the configuration step of your application. For example, in our Elasticsearch image, we bundle a nginx container to provide an auth layer in front of ElasticSearch. We use the metadata service to discover the ElasticSearch instances and reconfigure the nginx load balancer automatically.

### External Resources

Here are some great external resources to review:

* [ComputeStacks docker image library](https://git.cmptstks.com/integrations/docker-images){: target="_blank" }
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/){: target="_blank" }
* [Bitnami docker images](https://bitnami.com/stacks/containers){: target="_blank" }

## Recommended Best Practices

??? info "Don't reinvent the wheel"
    Try to use well-maintained images as the foundation for your custom image.

??? info "Enable SFTP Access"
    To enable SFTP access to your container, you will need to ensure file permissions are set correctly. For this to work, you will need the match the UID/GID of the user in your container, with the user of the SFTP/SSH container. Here is an example from a `Dockerfile` for our PHP image:

    ```docker
    RUN usermod -u 1001 www-data \
        && groupmod -g 1001 www-data
    ```

    You will also need to make sure you run `chown -R` on any files added to the container during the build process. This can be done as another `RUN` command, or as part of your `entrypoint` script.

    You may also want to rest all file/folder permissions with something like this:

    ```bash
    find . -type d -exec chmod 755 {} \; 
    find . -type f -exec chmod 644 {} \;
    ```

??? info "Don't hardcode configuration"
    Do not hard code any database credentials, or other configuration that requires up front knowledge of the environment. Instead, make all the options configurable as `ENV` variables that are accessible to an `entrypoint` script that can configure your application at run time. 

    See our [Wordpress image](https://git.cmptstks.com/integrations/docker-images/-/blob/master/wordpress/php7.3-litespeed/10-wordpress.sh){: target="_blank" } as an example.

    Our `entrypoint` script takes the database settings from the environment, and configures the wordpress database settings.

??? info "Adjust your webserver to retrieve the real IP of your visitors"
    Your application will sit behind the ComputeStacks load balancer. This means your application will not have direct access to the real remote address of the visitor. In order to access that data, you will need to read the header `X-Forwarded-For`.

??? info "Prevent SSL 'Too many redirects' error"
    By default, most images are configured to listen on port `80` with the global load balancer performing SSL offloading on your behalf. In this situation, your app may not realize that the user is connected over SSL and try to redirect them to `443`. In this scenario, you will most likely have a redirect error. 

    To accurately determine the protocol that the user is connecting over, you should look for the `HTTP_X_FORWARDED_PROTO` header being sent by our load balancer.

    Additionally, if you would like to also secure the connection between the application and our load balancer, you can optionally enable the `Backend SSL` setting in the appropriate ingress rule.

    For example, in our Wordpress image, we use:

    ```php
    <?php
    if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
        $_SERVER['HTTPS'] = 'on';
    }
    ```

??? info "Persist your data in volumes"
    By default, all docker containers are stateless. This means that the data within the container can go away at any time. To avoid losing data, it's important you define Volumes within ComputeStacks. 

    ComputeStacks has no awareness of your Dockerfile, therefore volumes defined in your Dockerfile will have *no effect.* You **must** define them in ComputeStacks.

??? tip "Test your image!"
    Be sure to test your image thoroughly before pushing to ComputeStacks. While we offer a lot of insight and data into your running container, the iterative process of resolving issues will be much faster locally then within the ComputeStacks environment.

## Define Your Image
Now that you've built, tested, and pushed, your image, it's time to configure it in ComputeStacks.

### Add your image
You have two options when creating your image in ComputeStacks. If you're using our built-in container registry, then you can navigate to your regsitry and click the tag you want to use. This will take you to the new image page with the registry details pre-filled out.

[ ![Link Registry Image](/images/content/building-images/container-registry-link.png){: style="width:60%;margin-left:15%;" } ](/images/content/building-images/container-registry-link.png){: target="_blank" }

To create an image hosted elsewhere, create a new image directly from the image section and enter the details. 

!!! warning "Enable Scaling"
    Does your image support horizontal scaling? If so, check this box and you'll be able to scale the app once it's deployed.

On this screen you will notice a `Command` setting: This is how you can pass parameters directly to process running within the container. Here are some examples of how to use that setting:

* MySQL & MariaDB, we set the following command: `--max_allowed_packet=268435456`.
* For Redis, we enable password authentication by referencing the [password setting](#settings): `/bin/sh -c redis-server --requirepass {{password}}`
    * `password` is the name of a setting we defined for this image. [see below](#settings).

!!! tip "Use /bin/sh when overriding the command"
    If you're trying to override the command itself and not just pass extra parameters, enclose your command with `/bin/sh -c `.

### Configure Parameters

Here are two examples from our Wordpress service:

[ ![Configure Wordpress Image](/images/content/building-images/image-settings-overview-wordpress.png){: style="width:48%;" } ](/images/content/building-images/image-settings-overview-wordpress.png){: target="_blank' }
[ ![Configure Wordpress Image](/images/content/building-images/image-settings-overview-mariadb.png){: style="width:48%;float:right;" } ](/images/content/building-images/image-settings-overview-wordpress.png){: target="_blank' }

<div style="clear:both;"></div>

#### Settings
This is the heart of your container configuration. You will define user-supplied settings, or dynamically generated strings, with this section. You can reference the result of these as variables in both the `command` setting, or in `environmental settings`, for both this container, and any container that references this container.

#### Volumes
This is where you define persistent storage for containers.

`Enable SFTP` will ensure you can SFTP into your image and access the files remotely.

#### Environmental Variables
These will be passed directly to the image as `-e` params. 

You have two choices:

1. **Static**: Whatever you type will be passed to the container
2. **Variables**: Dynamically generate the value

#### Ingress Rules
This tells ComputeStacks how to route traffic to your container.

* **Port**: What port is the container listening on? 
* **Protocol**: Define the protocol. For HTTP/S, all external traffic will be routed from 80/443, to the port defined in the first step. TCP/TLS will be assigned a random port.

##### Load Balancer Options

* **Enable External Access**: Setting this to true will enable external access from the load balancer.
* **TCP Proxy Options**: In general, this should always be disabled, otherwise you could break communication with your app. If your application specifically supports the `send-proxy` option, you can configure it here. ([learn more](https://cbonte.github.io/haproxy-dconv/1.8/configuration.html#5.2-send-proxy){: target="_blank" })
* **Cloudflare**: _This is only available when editing the ingress rule on a running service._ This allows you to restrict access to your service to only Cloudflare. ([learn more](/user_guide/cloudflare))

#### Persistent Storage (Volumes)

Any data changed or created by your container can be lost at any time, so it's important create volumes to persist your data. In addition to defining your volumes, you may also configure our integrated backup tool. ([learn more](/user_guide/backups))

We recommend only 1 volume per container, however we recognize that sometimes that is not feasible. We, for example, use 2 volumes in our [OpenLiteSpeed based images](https://github.com/ComputeStacks/docker/master/tree/php/open-litespeed){: target="_blank" }.

The primary reason we recommend using a single volume is to ensure that when backups are performed, they're getting a consistent point in time snapshot of your data.
