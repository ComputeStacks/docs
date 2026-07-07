# Installation: Finalize

**Congratulations!** 🎉

You should now be able to access your controller, and login with the credentials defined in the `inventory.yml` file.

If you're unable to access the portal, please run the validation script from the previous section.

---

## ComputeStacks Settings

Once you've logged in and navigated to the Admin, lets get a few basic setup. Navigate to **Settings -> Advanced Settings**.

You will want to review each setting, and update it as necessary.

### Custom Branding

### Billing

We currently have 2 options for integrating billing with ComputeStacks:

1. Configure Billing Web Hooks
2. Use our API Documentation to pull data and bill independently of ComputeStacks

## LoadBalancer Wildcard SSL Certificate

During the installation process, a self-signed wildcard certificate was installed to the new Load Balancer. To install a valid certificate, please refer to our LoadBalancer SSL Guide.

### SMTP Settings

If you do not have your own MTA, we recommend the following services:

- [Postmark](https://postmarkapp.com/)
- [Send In Blue](https://sendinblue.com/)
- [AWS Simple Email Service](https://aws.amazon.com/ses/)
