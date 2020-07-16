---
title: Clone a project
description: How to clone a project
---
# How to clone a project
*Currently, there is no automated way of cloning a project. This feature is on our roadmap, but for now the process is manual.*

!!! warning "Consider Images Instead"
    This guide is really designed for one-off situations. If you think you will ever have to do this more than once, I highly recommend you [create custom docker images](/user_guide/building-images) instead.

!!! danger "Back Up Your Data!"
    **Before performing any of these steps, backup all your data (including databases)!**
    
    We will be deleting files programmatically and it's possible to accidentally paste a command into the wrong server!

This guide will walk you through cloning a project, while making use of the tools provided by ComputeStacks. We will be using command line tools, however you can also perform many of these steps by using an FTP client *(SFTP protocol)* and phpMyAdmin.

!!! note ""
    In our example, we are using a standard wordpress site, and many of our commands below will include names and IP addresses that are unique to our project. Please be sure to update them according to your project.

## Overview

Here is an overview of the steps we will be performing:

1. Creating a new project with identical containers
2. Syncing data from the old wordpress site to the new one
3. Taking a mysql backup and restoring it in the new database container
4. Changing the domain in wordpress

## Create New Project

Our first step is to create a new project with wordpress and MariaDB. If you were also using redis, you would add that container now. When choosing packages, I recommend sticking with similar plans, or greater. Otherwise you may run into performance issues when importing the site data.

Once the project is started, navigate to the newly created project and **turn off the wordpress container**. 

## Sync Data

To make things easier, I recommend keeping two browser tabs open: 1 on the new project, and 1 on the old project. 

You will need to navigate to the SFTP detail page for each project and make note of the IP address, port, directory path, and ssh password. 

1. ssh into the _old project's_ ssh container and dump the database

    ??? question "How do I find the database name?"
        The database name will be the machine name of the service, without any dashes. You can either look at the `wp-config.php` file for the database name, or most likely it will be the only non-system database in mysql. In that case, you can just look at all databases with:

        !!! note
            The `-p` flag below will prompt for the password, so you won't be able to copy-paste the entire command into your terminal.

        ```bash
        mysql -h 10.10.123.10 -u root -p
        show databases;
        exit
        ```

    ```bash
    ssh -p 15000 sftpuser@100.100.100.100
    cd ~/apps/boring-blackwell52/wordpress/html
    mysqldump -u root -p mydatabase > mydatabase.sql 
    ```

2. ssh into the _new project's_ ssh container and wipe out the existing wordpress site.

    !!! tip "Save DB settings"
        Before wiping out the default wordpress installation on the new container, I recommend copy/pasting the database configuration from the `wp-config.php` into a local text editor. We will need to change the old `wp-config.php` file to match the new one later one.

        ??? example "`wp-config.php`"

            ```php
            <?php
            /** The name of the database for WordPress */
            define( 'DB_NAME', 'boringbohr55' );

            /** MySQL database username */
            define( 'DB_USER', 'root' );

            /** MySQL database password */
            define( 'DB_PASSWORD', '4x1QlUf8w9XCWa' );

            /** MySQL hostname */
            define( 'DB_HOST', '10.10.50.23' );
            ```

    ```bash
    ssh -p 16000 sftpuser@100.100.100.100
    cd ~/apps/boring-bohr55/wordpress/html && rm -rf wordpress/*
    ```

3. Copy data from the old container to the new one.

    ??? question "Where do I find the directory paths used in your example?"
        If you navigate to the login/setup page of your service _(where the SFTP details are stored)_, you will see a section called **SFTP Volume Paths**.

    ```bash
    rsync -e 'ssh -p 15000' -aP sftpuser@100.100.100.100:/home/sftpuser/apps/boring-blackwell52/wordpress/html/wordpress/ wordpress/
    scp -P 15000 sftpuser@100.100.100.100:/home/sftpuser/apps/boring-blackwell52/wordpress/html/mydatabase.sql .
    ```

4. Import database

    _See the tip in (1) on how to find the database name._

    !!! abstract "Reset New Database"
        The new database will be pre-populated with a fresh wordpress install. Lets wipe that out.

        ```bash
        mysql -h 10.10.50.23 -u root -p
        drop database new-database;
        create database new-database;
        exit
        ```

    !!! abstract "Import database"
        With a fresh database, lets import our data.

        ```bash
        cd ~/apps/boring-bohr55/wordpress/html
        mysql -u root -p new-database < mydatabase.sql
        ```

## Update wp-config.php

Update the newly-migrated wordpress site's `wp-config.php` with the new database configuration. If you saved the settings into your text editor from step (2), you can simply copy/paste them back.

## Update the wordpress domain

Installed on our ssh containers is the [wp-cli](https://wp-cli.org/){: target="_blank" }. We will use that to programmatically change our domain name. Here is an example:

```bash
cd ~/apps/boring-bohr55/wordpress/html/wordpress
wp search-replace 'myoldwordpress-site.com' 'my-new-website.com'
```

!!! tip "Tip for moving from www to non-www."
    If your old site had a domain in the form of `www.example.com` and you're moving to `newsite.com`, then run the `search-replace` function twice, but start with the `www` one.

    ```bash
    wp search-replace `www.example.com` `newsite.com`
    wp search-replace `example.com` `newsite.com`
    ```



