---
title: WHMCS Image
description: Running WHMCS on ComputeStacks
---
# Running WHMCS on ComputeStacks

Using our [provided image](https://hub.docker.com/r/cmptstks/whmcs){: target="_blank" }, it's easy to deploy and manage WHMCS on ComputeStacks.

Our image is based on our [php7.3-litespeed](https://hub.docker.com/r/cmptstks/php){: target="_blank" } image which includes support for cron. 

Key Facts:

* All files are stored in `/var/www/html`
* Cron is managed here: `/var/www/html/crontab`
    * Simply add your changes here and restart the container to activate them
* The document root for this container will be `/var/www/html/whmcs/whmcs-public`.

This layout allows you to make the recommended modifications to WHMCS by moving `templates_c`, `downloads`, and `attachments`, outside of the public directory. 

## Complete Installation

After launching for the first time, the container will automatically create the database and install WHMCS to the directory structure listed above. To finalize the process, you will need to complete the last steps by using the WHMCS web installer. 

Navigate to your site's URL and follow the steps they list.

Config Option     | Value
------------------|------------------------------------------------------------------------------------------------------------------
Database Host     | This will be the private IP Address of the database container that would have been added during the initial order
Database Name     | This will be the value listed under `Whmcs dbname` in ComputeStacks
Database Port     | `3306`
Database Username | `root`
Database Password | This will be visible under the database service in ComputeStacks.

## Next Steps

Please review the [WHMCS Further Security Steps](https://docs.whmcs.com/Further_Security_Steps){: target="_blank" }