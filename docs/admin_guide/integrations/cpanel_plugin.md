---
title: cPanel
description: How to install our cPanel plugin
---
# ComputeStacks cPanel Plugin

Our ComputeStacks plugin offers a way to offer additional applications in your cPanel environment. We use a client side interface that we run in our plugin, and includes direct integration with cPanel's domain functionality to easily link domains hosted in cPanel, with ComputeStacks.

### Features

* Support for [WHMCS](https://www.whmcs.com){: target="_blank" }.
* Automatically create users in ComputeStacks, so your users won't have to login someone else.
  * (optionally) we support asking the user to authenticate with ComputeStacks via an oauth popup screen.
* Simplified version of our full controller interface.

<br>

[ ![Access Env Params](/images/content/cpanel/cpanel-main.png){: style="border: 1px solid #ccc;padding:5px;float:left;width:46%;" } ](/images/content/cpanel/cpanel-main.png){: target="_blank" }

[ ![Access Env Params Overview](/images/content/cpanel/cpanel-order-package.png){: style="border: 1px solid #ccc;padding:5px;float:left;width:46%;margin-left:6%;" } ](/images/content/cpanel/cpanel-order-package.png){: target="_blank" }

<br>
<div style="clear:both;"></div>

<hr>

## Configure ComputeStacks

The first required step is to generate your API Credentials for cPanel. Login or impersonate the user who will own the oauth credentials -- this should be an admin user. Our default installation will create a cPanel service account that you may use.

!!! quote ""
    `Navigate to Profile -> Developer -> Applications`

You have two ways of connecting to ComputeStacks:

1. **Have the cpanel user authenticate with ComputeStacks:** This requires that the user already have a ComputeStacks account.
2. **Automatically generate a ComputeStacks account and log the user in:** This is our recommended approach and offers the least amount of onboarding friction.

!!! abstract "Authenticate with ComputeStacks"
    In this configuration, our plugin will ask the user to authenticate directly with ComputeStacks. This is preferred when you have a mixed-user setup: cPanel users will also be using our full control panel.

    In ComputeStacks, create an application with the following settings:

    * Redirect URI: This will be in the form of:
        * `https://<my-cpanel-server>:2083/frontend/paper_lantern/computestacks/torii/redirect.html`
        * We will inject the session ID into the URL, so we don't need to create any kind of variable or placeholder for that here.
    * Confidential: `false` (unchecked)
    * Scopes: all scopes, except the following: `admin:read`, `admin:write`, `register`.
    * Owner: none

!!! abstract  "Automatically creating the user and store the credentials in cPanel"

    This is the has the least amount of friction for the user. In this mode, the cPanel plugin will automatically create a user in ComputeStacks, and store the credentials locally in cPanel's secret store for future use.

    To set up your plugin in this configuration, create an application in ComputeStacks with the following settings:

    * Redirect URI: `urn:ietf:wg:oauth:2.0:oob`
    * Confidential: `true` (checked)
    * Scopes: `public`, `register`.
    * Owner: none

    This will be used to perform the initial registration and account setup. The cPanel plugin will authentication credentials locally and perform automatic authentication in the future. 

    Now create the same app under as the previous section, but this time set the **Redirect URI** to: `urn:ietf:wg:oauth:2.0:oob`. This will be the app ID used to identify what our user can do with their API credentials.

## Install Plugin on cPanel Server

### Build Plugin Package

??? tip "How to pin plugin to a specific version"
    These instructions will follow the `master` branch of the plugin. If you would like pin to a specific version, then after cloning the repo (or running `git pull`), you may checkout a specific release with: `git checkout v1.0`, where `v1.0` is the name of the release _(git tag)_.

    You can see a list of available releases [here](https://github.com/ComputeStacks/cpanel-plugin/releases){: target="_blank" }.

1. SSH onto your server and navigate to `/usr/local/src`
2. Clone the repository to `computestacks-plugin`.
3. Copy the sample configuration file to `computestacks.ini` and set your API credentials and endpoint.

    ??? question "What is the `autoLogin` setting for?"
        **tl;dr** For most installations, leave `autoLogin = true`.
        
        This setting determines if the plugin will automatically create a user in ComputeStacks for this cpanel account. If false, they will instead be prompted to login to ComputeStacks and link their account to this cpanel account.

!!! example
    ```bash
    cd /usr/local/src \
    && git clone https://github.com/ComputeStacks/cpanel-plugin.git computestacks-plugin \
    && cd computestacks-plugin \
    && cp computestacks.ini.sample computestacks.ini
    ```

### Deploy Plugin Package

#### Install UI Files

Copy the contents of `plugin_files` to `/usr/local/cpanel/base/frontend/paper_lantern/computestack`.

!!! example
    ```bash
    cd /usr/local/src/computestacks-plugin/ \
    && mkdir -p /usr/local/cpanel/base/frontend/paper_lantern/computestacks \
    && rsync -aP plugin_files/ /usr/local/cpanel/base/frontend/paper_lantern/computestacks/
    ```

#### Install Plugin

Before running the commands, review the `computestacks/install.json` file. Examples of changes you can make:

* Change the name of the group from ComputeStacks to your brand for this offering (e.g. Cloud apps, Containers, etc). 
* Add or remove app icons to the group
* Set where this group will appear in the in the cPanel interface. By default we install it at the top.

Install the plugin with: `/usr/local/cpanel/scripts/install_plugin computestacks`

!!! note ""
    The `computestacks` portion of the install command is the directory name inside our plugin. If you changed the directory name, please adjust accordingly. 
    Furthermore, you may see a `computestacks.tar.gz` file instead of a directory. You may either uncompress that and make your changes, then run the command above, or you can install the defaults by running: `/usr/local/cpanel/scripts/install_plugin computestacks.tar.gz`

### Activate Plugin

With the plugin installed, the last step is to enable it within the **[Feature Manager](https://docs.cpanel.net/whm/packages/feature-manager/){: target="_blank" }** of WHM.

??? question "How do i find the plugin in the Feature Manager?"
    Look for the individual icon names within the Feature Manager, not _Compute Stacks_. Each item in the `install.json` will appear separately here.

    You can see an example [here](/images/content/cpanel/cPanel Plugin Feature Manager.pdf){: target="_blank" }.

## Image Specifics

### Redis
In order to connect to redis over TLS on cPanel, you will need to be running at least php7.2. Additionally, you will need to ensure that phpredis v5.0 or greater is installed. 

??? question "How do I install phpredis on cpanel?"
    You can install phpredis on cpanel by logging into WHM and navigating to: **Software -> Module Installers -> PHP PECL**. Search for `redis` and install for all version of php offered.

    [ ![WHM PHP Redis](/images/content/cpanel/cpanel-php-redis.png){: style="border: 1px solid #ccc;padding:5px;width:46%;" } ](/images/content/cpanel/cpanel-php-redis.png){: target="_blank" }

[Click to learn more](/user_guide/container_images/redis) about our redis implementation on ComputeStacks.

## FAQ & Troubleshooting

??? question "How do I uninstall the plugin?"
    1. Run `/usr/local/cpanel/scripts/uninstall_plugin` on either the directory that contains the `install.json` file, or on the compressed archive.
    2. Delete the directory: `/usr/local/cpanel/base/frontend/paper_lantern/computestacks`

??? question "How do I update the plugin?"
    The main interface is all client side and loaded from our CDN. However, our cpanel-specific code does run locally on the server and will need to be updated from time-to-time. 

    !!! tip
        If you're only making changes to the `install.json` file, then you don't need to perform all these steps. Just re-run the `/usr/local/cpanel/scripts/install_plugin` command.

    To update the plugin, simply perform a git pull from the plugin directory (`/usr/local/src/computestacks-plugin/`) and rsync the plugin files the same you performed the installation.

    If you made any changes to the local directory, you will get a git merge warning during the git pull operation. Be sure to clear those up before running rsync.

    If you are pinned to a specific release _(tag)_, you will need to refresh the tag list and checkout the new tag.paper_lantern/computestacks/`

    !!! abstract "Example"
        ```bash
        cd /usr/local/src/computestacks-plugin/ \
        && git pull origin master \
        && rsync -aP plugin_files/ /usr/local/cpanel/base/frontend/paper_lantern/computestacks/
        ```
