---
title: Migrate Existing Application
description: How to move an existing site to ComputeStacks.
---
# How to migrate an existing application

## Overview
When onboarding a new application to ComputeStacks, there are two directions you can go:

### Traditional containerized application deployment process.
This is typically used by developers, or users with container experience.
The application will be packaged into the container itself and will not enable SFTP access to the container. This allows for versioned containers and integration with build pipelines (CI).

### Traditional FTP/SFTP setup
This would be the legacy web hosting model where the user will login using their FTP/SFTP application of choice.

All of our current marketplace images (Wordpress, PHP, Magento, etc) follow this model. We have a standardized image without any application data stored in the container. You will upload their application to the volume using the SSH/SFTP container attached to their project.

This guide will focus on #2: Migrating a custom application from a traditional hosting environment, while maintaining the SFTP access they're used to.

Throughout this application, we will be using a demo php/mysql application as our example.

## Survey Existing Application

Our first step is to survey their existing application and determine which containers we will need, and if we need to build anything for their application. In general, our goal is to reuse existing images that we already have built, and make modifications using the existing tools (e.g. `htaccess`, `cron jobs`), rather than build a custom image that we then need to maintain.

### Identify Data Persistence Requirements
What kind of data is being stored, and where is being stored currently? If the application is expecting data to be persisted outside of a standard directory structure, we may need to build a custom image.

With ComputeStacks, you can have as many volumes as you want. However, our backup system will backup each volume separately, so we recommend trying to keep each image to only a single volume to ensure a consistent backup. 

### Required Services
Containers in general expect there to be only a single running process. If this application has multiple services running, then we may need to create custom images and break out each service into their own service. Here are some common examples of dependent services that we need to deploy.

#### Mail
How does the application deal with mail? Many php applications rely on sendmail being available, however our container images do not directly support sending mail and many providers specifically block outbound mail from their platform. We recommend using a commercial service for sending mail. This provides a better experience for your users (better email deliverability), less support requests, and less work for your support team since they won't have to deal with outbound spam.

Here are a few providers we recommend: [Postmark](https://postmarkapp.com){: target="_blank"}, [Sendgrid](https://sendgrid.com){: target="_blank"}, [AmazonSES](https://aws.amazon.com/ses){: target="_blank" }. You can optionally use an SMTP container like MailHog to process mail.

#### Redis
Redis is very easy to add to your application with ComputeStacks, simply choose it from the store. One thing to note is that our image does not persist data, it is configured as an in-memory store only. If the application requires redis to persist data through restarts, you will want to create your own and add a volume to it. 

#### Cron Jobs
Our PHP images do run the cron daemon inside the same container. This makes it easy to migrate existing web applications over. When you SFTP or SSH into your container, you will see a file in the root of the volume called crontab. Add your cronjobs here and restart the container for them to be installed.

!!! tip ""
    Inside of the container the full path will be `/var/www/html/crontab` and not `/home/sftpuser/apps/<service-name>/webroot/crontab`.

### Identify Configuration Strategy
Each application will configuration differently, but they can generally be drilled down to two different strategies: Configuration Files, and Environmental Parameters. When migrating your application to ComputeStacks, review the configuration files and see how they expect configuration data to be passed to it. In our example, the developer is using Environmental Parameters stored in a `.env` file, so that is how we will proceed.

#### Configuration Files
With configuration files, all the database parameters, session keys, etc., are stored in plain text files on the volume. This is how, for example, Wordpress manages their configuration.

#### Environmental Parameters
With environmental parameters, the configuration files will reference the environment for the value. This is the preferred method of configuration because it means your application can easily be moved to a different environment, without having to modify any files.

## Launching Containers
For this example, create a new project with: MariaDB 10.4, PHP 7.3 with OpenLiteSpeed, Redis, and phpMyAdmin.

### MariaDB 10.4
Once you launch the container, we will need to manually create the database and import their database backup. On the main project page that lists all the containers in your project, click login on the MariaDB container. This will provide you your link to phpMyAdmin and the root password. 

!!! danger ""
    I recommend matching the new database collation to the existing database you're importing. If you look at the database export and find one of the `CREATE TABLE` statements, you should see at the end the line `COLLATE=`. Try to match that in phpMyAdmin.

After creating the database, navigate to the **Import** tab and upload your database dump.

### PHP & OpenLiteSpeed
Our PHP 7.3 container, which is powered by OpenLiteSpeed, comes with a great web administrator. We will use this to make final configuration changes to the container. However, first we need to upload our application. Using either SFTP or rsync, move the application to the volume. Below is an example using rsync to upload our application to our example container `jovial-poitras82`.

!!! abstract "Importing data and setting up the webserver"
    In this example we are using the ip `1.1.1.1` and port `29656`. _You need to change these to the values listed for your specific application in ComputeStacks!_

    ```bash
    # Step 1: is the clear out the sample application included in the container
    ssh -p 29656 sftpuser@1.1.1.1
    rm ~/apps/jovial-poitras82/webroot/html/default/index.php
    rm ~/apps/jovial-poitras82/webroot/html/default/info.php
    exit

    # Step 2: is to rsync the files 
    cd /path/to/my/app
    rsync -e 'ssh -p 29656' -aP . sftpuser@1.1.1.1:apps/jovial-poitras82/webroot/html/default/
    ```

!!! abstract "Reset File Permissions"
    The third step is to reset file permissions. Regardless of how you got the files onto the server, most likely the folder/file permissions are incorrect and will result in a `403 FORBIDDEN` error page.

    ```bash
    # Step 1: SSH back into the ssh container
    ssh -p 29656 sftpuser@1.1.1.1

    # Step 2: Navigate to the root of the application
    cd ~/apps/jovial-poitras82/webroot/html/default

    # Step 3: Reset folder permissions
    find . -type d -exec chmod 755 {} \;

    # Step 4: Reset file permissions (Note: Depending on how many files you have, this can take several minutes)
    find . -type f -exec chmod 644 {} \;

    # Step 5: Review the application specific recommendations for file/folder permissions and adjust accordingly.

    # Step 6: Although not always required, if you still see 403 forbidden errors, you may need to restart the container.
    ```

Once it's deployed, navigate to the main service page and locate the web administrator URL and password. The password will be labeled **Litespeed Password**, and the URL will be the one routed to port `7080`. Click that and login.

The default configuration for our PHP 7.3 Litespeed image expects the application to live in /var/www/html/default, however symfony uses a different application structure where the index lives below the public/ directory, so we will need to adjust the default vhost.

1. Login to the web administrator and navigate to Virtual Hosts and click on Default to view the default virtual host.
2. Click the edit button in the top right corner of the first section (Base) to edit the section.
3. Ensure that the Virtual Host Root is `/var/www/html/default`.
4. Click the General tab and edit the first box (Also General). Set the Document Root to $VH_ROOT/public.
5. Click the  icon to save your changes.
6. Now we need to reload the webserver. You can do this by restarting the container, or issuing a graceful restart in the web administrator.
    1. Click the server name below the word 'OpenLiteSpeed' in the upper left-hand corner.
    2. Choose graceful restart.

#### Configuring container to link to other required containers

As stated previously, we will be using environmental parameters to pass configuration data to our application.

Back in the ComputeStacks interface, navigate to the service overview page, click on the gear icon and choose Environment. Here you will see a list of the existing environmental parameters, click the  icon to add a new one.

We will be creating the following environmental parameters for our service:

* DATABASE_URL
    * In our example, this is in the form: `mysql://username:password@ip-address/databasename`.
    * Our username will be root, and the ip address will be the direct local IP of the mariadb container.
* APP_SECRET
* APP_ENV
* MAILER_URL
    * In our example, this is in the form: `smtp://username:password@mailserver`
* MAILER_FROM
* MAILER_TEST

After you have added all the environmental parameters, you will need to issue a **rebuild** of your container.

![Access Env Params](/images/content/container-service-environment-menu.png){: style="border: 1px solid #ccc;padding:5px;margin-bottom:25px;" }
![Access Env Params Overview](/images/content/container-service-environment-overview.png){: style="border: 1px solid #ccc;padding:5px;" }
