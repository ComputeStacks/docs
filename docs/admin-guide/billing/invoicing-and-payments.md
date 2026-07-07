# Billing: Invoicing & Payments

While ComputeStacks generates all of the billing data, *we do not directly handle payments or generating invoices*. We rely on third party integrations for this part of the billing process.

This affords us the flexibility to work in a variety of environments.

## Using Webhooks

Using our [Billing WebHooks](../../integrations/webhooks.md) is a popular alternative for providers with a custom control panel & billing system. With this integration option, you can onboard customers how you normally would in your system, and using SSO, log them into ComputeStacks. Then on each billable event, we will send a webhook to your system to process that usage.
