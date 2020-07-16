---
title: Wordpress (Apache)
description: Migrate from Wordpress Apache to LiteSpeed
---
# Migrate from Apache to LiteSpeed

Our [default Wordpress installation](wordpress.md) now uses the [Open LiteSpeed](https://openlitespeed.org){: target="_blank" }. This guide will aid in your transition to our new image.

## Overview

Before migrating to the new image, be sure to understand a few important changes:

1. The webserver will be moved from Apache to [OpenLiteSpeed](https://openlitespeed.org){: target="_blank" }. While all widely used `.htaccess` directives are supported, you may find that some lesser-used rules may not function. Please consult the Open Litespeed documentation if you find that your site is not behaving as expected.
2. *Caching:* We recommend that you use [Litespeed's own Wordpress caching plugin](https://wordpress.org/plugins/litespeed-cache/){: target="_blank" }. This is designed to work best with the Open Litespeed web server and will be the most stable for your site. The Litespeed caching plugin supports many common caching techniques including page caching, css/js minification and optimization, image optimization, and object caching through redis or memcached. However, we have had success using the W3T Caching plugin with browser caching disabled (this is handled by Litespeed).
3. You will find that there is now a web administrator. You can use this to make configuration changes to the litespeed webserver; these changes are persisted on a separate volume attached to your container.

## Preflight

1. If you're using horizontal scaling, scale your service back to 1 container.
2. Take a backup of both your database and wordpress containers.
3. If you have any caching plugins enabled, clear their cache and disable them.

## Migration

The migration process is fairly simple, and involves creating a new wordpress & database container with the litespeed image and migrating your wordpress data over.

* Create a new Wordpress Litespeed container and it's associated MariaDB 10.3 container.
* Stop both the existing Wordpress container, and the new wordpress container.

### Migrate Database 

    !!! tip ""
        This is current as of v5.2. In a future CS update, you will be able to do an in-place container upgrade of the database

    Dump & Import Existing database

### Migrate wordpress data

#### Before Moving Data
Locate and take note of the `SFTP Volume Paths` under the SFTP/SSH credentials section within ComputeStacks.

The ***new*** container should be in the form of: `/home/sftpuser/apps/<service-name>/wordpress`

The ***old*** container should be in the form of: `/home/sftpuser/apps/<service-name>/Wordpress`

There is a difference in folder structure between the new and old wordpress containers. Be sure that when you're copying files, you're copying from the website root of one site to another.

!!! tip ""
    In the following examples, we are assuming that the web root of both containers are:

    NEW: `/home/sftpuser/apps/<service-name>/wordpress/html/wordpress/`
    
    OLD: `/home/sftpuser/apps/<service-name>/Wordpress/`

#### Perform Migration

!!! danger ""
    SSH Into the SFTP Container of the _**NEW**_ Wordpress container you just created.

1.  Delete the default wordpress installation
    ```bash
    rm -rf /home/sftpuser/apps/<service-name>/wordpress/html/wordpress/
    ```
2.  Now determine if this SFTP container is also in use by old wordpress site by trying to `cd` to the
    SFTP volume path of the OLD wordpress container.
    IF that exists, proceed to 2(a), otherwise use 2(b).

    ??? example "(A) Local rsync: old site to new volume"
        Data is available in the same SFTP/SSH container

        ```bash
        rsync -aP /home/sftpuser/apps/<old-service-name>/Wordpress/ /home/sftpuser/apps/<new-service-name>/wordpress/html/wordpress/
        ```

    ??? example "(B) Remote rsync: old site to new volume"
        For this, you will need the IP, port, and password of the old sftp container.

        ```bash
        rsync -e 'ssh -p <port-of-old-sftp-container>' -aP sftpuser@<ip-of-old-sftp-container>:/home/sftpuser/apps/<old-service-name>/Wordpress/ /home/sftpuser/apps/<new-service-name>/wordpress/html/wordpress/
        ```

3.  Modify `wp-config.php` using vim or nano and update the IP address & password of the database. The database name should be the same.

4.  Adjust file permissions of the new wordpress site

```bash
cd /home/sftpuser/apps/<new-service-name>/wordpress/html/wordpress/ \
find . -type d -exec chmod 755 {} \; 
find . -type f -exec chmod 644 {} \;
```

5. Start the new wordpress container
6. Edit the domain in the project and point the domain to the new service & ingress rule (port 80).
7. Verify your site is working and re-enable caching (preferably with the the [Litespeed Caching Plugin](https://wordpress.org/plugins/litespeed-cache/))
8. (optional) Scale out horizontally
9. (optional) Delete the old wordpress apache container and the old database container

## Troubleshooting

??? question "The site does not load, or displays a blank white page"
    This may be caused by incorrect file/folder permissions that Litespeed requires. You can quickly reset everything by running the following commands from the SFTP container:

    ```bash
    cd ~/apps/new-litespeed-container/webroot/
    find . -type d -exec chmod 755 {} \;
    find . -type f -exec chmod 644 {} \;
    ```

    *Note: Both `find` commands may take some time to run depending on how many files & folders you have in your site.*