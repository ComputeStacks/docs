---
title: WHMCS
description: WHMCS Integration
---
# WHMCS Integration

## Overview

The ComputeStacks integration for WHMCS provides an easy onboarding experience for your customers. It offers a customized ClientArea integration, along with seamless onboarding.

* Each service in WHMCS corresponds to a single ComputeStacks account
* ClientArea output for quick overview
* Easy SingleSignOn buttons in both ClientArea and Admin
* Support for charging an initial deposit on registration, which is then added as an account credit.
* Multiple Currency support
* Import CS accounts into WHMCS using the [Server Sync Tool](https://docs.whmcs.com/Server_Sync_Tool){: target="_blank" }

[ ![Admin](/images/content/whmcs/whmcs-admin-service.png){: style="border: 1px solid #ccc;padding:5px;float:left;width:46%;" } ](/images/content/whmcs/whmcs-admin-service.png){: target="_blank" }

[ ![ClientArea](/images/content/whmcs/whmcs-clientarea.png){: style="border: 1px solid #ccc;padding:5px;float:left;width:46%;" } ](/images/content/whmcs/whmcs-clientarea.png){: target="_blank" }

<div style="clear:both;"></div>

!!! warning "Service Terminations"
    This plugin will not delete any services in ComputeStacks. When a WHMCS service is terminated, this plugin suspends the account in ComputeStacks, which stops all running services. You will then need to manually delete the user. _If you wish to have WHMCS automatically delete the users in ComputeStacks, please contact your CS support team._

## Installation

[Download Our Plugin](https://github.com/ComputeStacks/billing-whmcs/archive/master.zip) and upload the contents to your WHMCS server. The folder structure included should match your local installation. Ultimately, the `computestacks` directory under `whmcs/modules/servers/`, should be placed on your WHMCS server at `modules/servers/`.

!!! abstract ""
    The current version requires WHMCS v8+. For WHMCS v7 support, please use our [latest v2 version](https://github.com/ComputeStacks/billing-whmcs/releases){: target="_blank" }.

## Configure WHMCS

### Add Server

Create a new server in WHMCS and supply your ComputeStacks installation details.

!!! note ""
    You will need to generate API Credentials using an admin user in ComputeStacks. The API Key in ComputeStacks corresponds to the username field in WHMCS, and the API Secret is the password.

### WHMCS Product

Our integration is designed to work in conjunction with our User Group functionality within ComputeStacks. This is useful if you decide to offer different tiers of service.

To create your ComputeStacks product, create a new product group and product with the settings:

* Pricing:
  * With Deposit: Choose OneTime fee and set your deposit amount
  * Without Deposit: Choose Free
* Module: ComputeStacks
  * User Group: Your choice
  * Apply Credit: If you added a one-time fee, you can optionally convert that to an account credit.
    * _Note: This will take place at the moment the order is paid._
  * Module Setup:
    * With Account Credits, we recommend either:
        * _**Automatically setup the product as soon as the first payment is received**_ (preferred for best user experience)
        * _Automatically setup the product when you manually accept a pending order_
    * Without Account Credits, we recommend either:
        * _**Automatically setup the product as soon as an order is placed**_ (preferred for best user experience)
        * _Automatically setup the product when you manually accept a pending order_

## Configure ComputeStacks

Before we proceed, you will need to first [generate API credentials](https://docs.whmcs.com/API_Authentication_Credentials){: target="_blank" } for ComputeStacks. Here are the roles that we need assigned:

!!! success ""
    * `Billing -> AddBillableItem`
    * `Client -> GetClients`
    * `Client -> GetClientsDetails`
    * `Client -> GetClientsProducts`
    * `Products -> GetProducts`
    * `Products -> UpdateClientProduct`
    * `Servers -> GetHealthStatus`

!!! danger "WHMCS Access Control"

    Please add the controller IP address to the **API IP Access Restriction** [section in the WHMCS settings](https://docs.whmcs.com/Security_Tab#API_IP_Access_Restriction){: target="_blank" }.

    Alternatively, setup an [access key](https://developers.whmcs.com/api/access-control/){: target="_blank" }.

In ComputeStacks, navigate to the `Administrator -> Advanced Settings -> Billing Module`.

1. Edit **Billing Module** and choose 'WHMCS' and click save. Once you do, additional settings will become available.
2. Set both **Whmcs Api Key** and **Whmcs Api Secret**
3. If you set an API Access Key in WHMCS, then you can enter that under **Whmcs Access Key**.

With WHMCS enabled, ComputeStacks will by default disable the registration form to ensure all new users come through WHMCS. Administrators can manually create users from within the admin.

If you wish to keep the registration form on, you can manually enable that under `Settings -> Advanced Settings -> General` and clicking **Signup Form** `No`. Clicking will toggle to `yes`.

Keep in mind that enabling user registration on the portal will bypass WHMCS and those users will not be charged. 

The final step is to set your prices under `Settings -> Billing Plans`.

## Upgrading From v1

Version 2 of our WHMCS plugin is a major change from V1 and will require that updates are made to both ComputeStacks and WHMCS.

??? example "Feature Matrix Table"
    | Feature                    | v1                                                                                                                                                                                                                                 | v2                                                                                                               |
    |----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
    | Accounts                   | 1 WHMCS user = 1 CS User                                                                                                                                                                                                           | WHMCS Users can have multiple CS Accounts (Service = CS Account)                                                 |
    | ClientArea                 | No ClientArea integration                                                                                                                                                                                                          | ClientArea Integration with SSO for both users and admins                                                        |
    | Pre-Paid Billing (Monthly) | ComputeStacks would generate an order for each billable action (upgrades/new orders/scaling), redirect the user to the invoice (if it created). Our WHMCS plugin would then attempt to redirect the user back to CS after payment. | no longer available, hourly only.                                                                                |
    | Hourly Billing             | CS will aggregate usage and create billable items                                                                                                                                                                                  | No Change                                                                                                        |
    | Ordering in WHMCS          | Not available                                                                                                                                                                                                                      | Supported                                                                                                        |
    | CS Registration            | Users who signed up in CS would automatically be created in WHMCS. Logging into CS used their WHMCS ClientArea credentials                                                                                                         | CS Users are _not_ created in WHMCS. Logging into CS uses the username/password set by the WHMCS service module. |

### Upgrading

If you do not have any pre-paid monthly users with active services, then the upgrade process is fairly straight forward. Simply remove the old plugin and install our new one following the installation instructions found in our `README.md` file.

You may then use the [Server Sync Tool](https://docs.whmcs.com/Server_Sync_Tool){: target="_blank" } to create local services to enable ClientArea support. During the import process, be sure to set "reset password". This will link the WHMCS service to their ComputeStacks account, and set the password that's generated by WHMCS.

If there are existing monthly pre-paid customers, then you will want to work through the following items:

1. Create a new metered billing plan in CS (or update the old one and change all the prices to hourly) and assign all of those users to that billing plan.
2. Delete all the existing pre-paid monthly services in WHMCS.
    
    !!! danger "DO NOT RUN ANY MODULE COMMANDS!"
        This will also delete the service in ComputeStacks!

3. Create the product in WHMCS, following our `README.md`.
4. Run the server sync tool in WHMCS
