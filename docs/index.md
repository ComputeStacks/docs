# ComputeStacks Documentation

Open-Source turnkey platform enabling providers to launch a unique hosting offering, without having to build anything.

[Source code](https://github.com/ComputeStacks) ·
[Community forum](https://github.com/orgs/ComputeStacks/discussions)

<div class="grid cards" markdown>

-   🚀 __Getting started__

    ---

    Understand the architecture, then plan, prepare, perform, and finalize your installation.

    [:octicons-arrow-right-24: Getting started](getting-started/architecture-overview.md)

-   🔌 __Integrations__

    ---

    Connect billing and provisioning through the API and webhooks.

    [:octicons-arrow-right-24: Integrations](integrations/webhooks.md)

-   🛠️ __Admin guide__

    ---

    Billing plans, backups, and day-to-day platform operations for operators.

    [:octicons-arrow-right-24: Admin guide](admin-guide/billing/overview.md)

-   📦 __User guide__

    ---

    Backups, developer tools, image documentation, and how-to guides for end users.

    [:octicons-arrow-right-24: User guide](user-guide/backup-system.md)

-   ⚙️ __API reference__

    ---

    Full v8.0 reference for the User API (UAPI) and Manage API (MAPI).

    [:octicons-arrow-right-24: API reference](api/index.md)

</div>

## Common questions

??? question "How do I access my container?"
    **File access:** You may connect via SSH and SFTP directly to the volume where your data is stored.

    **Network access:** You have a few different options to connect. You may use the cloud shell via SSH and tunnel directly to the service you're connecting to. Alternatively, you can expose specific ports and access your service via the internet. Just be sure your service requires authentication to ensure no unauthorized access occurs.

??? question "What if the image I want isn't available to order?"
    ComputeStacks has powerful tools to deploy Docker containers. Please see our guide on [building images](user-guide/how-to/building-images.md) for ComputeStacks, and how to add them to the platform.

??? question "How do I send mail from my website?"
    Most providers who deploy ComputeStacks block outbound SMTP. Our recommended approach is to use a third party SMTP provider. Please see our guide on [how to send mail](user-guide/concepts/sending-mail.md) from your container.
