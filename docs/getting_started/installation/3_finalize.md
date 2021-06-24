---
title: Finalize Installation
description: Finalize Installation
---
# Finalize Installation

**Congratulations!** 🎉 

You should now be able to access your controller, and login with the credentials defined in the `inventory.yml` file.

If you're unable to access the portal, please run the validation script from the previous section.

---

## ComputeStacks Settings

Once you've logged in and navigated to the Admin, lets get a few basic setup. Navigate to **Settings -> Advanced Settings**.

You will want to review each setting, and update it as necessary.

### Custom Branding

### Billing

We currently have 3 options for integrating billing with ComputeStacks:

1. Use our [WHMCS](../integrations/whmcs_plugin.md) plugin
2. Configure [Billing Webhooks](../integrations/webhooks.md)
3. Use our [API](https://demo.computestacks.net/documentation/api){: target="_blank" } to pull data and bill independently of ComputeStacks

## LoadBalancer Wildcard SSL Certificate

During the installation process, a self-signed wildcard certificate was installed to the new Load Balancer. To install a valid certificate, please refer to our [LoadBalancer SSL Guide](../../admin_guide/cluster_management/load_balancer.md#ssl-settings).

### SMTP Settings

If you do not have your own MTA, we recommend the following services:

* [Postmark](https://postmarkapp.com){: target="_blank" }
* [Send In Blue](https://sendinblue.com){: target="_blank" }
