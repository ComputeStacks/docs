# Manage API (v8.0)

!!! success
    You're currently viewing the latest version of the Manage API (MAPI).

[Billing](billing/index.md)

[Container Services](container-services.md)

[DNS Zones](dns-zones/index.md)

[Images](images/index.md)

[Infrastructure](infrastructure/index.md)

[Networking](networking.md)

[Projects](projects/index.md)

[Registry](registry/index.md)

[Subscription](subscription/index.md)

[User](user/index.md)

The Management API (MAPI) is used to access super-user access to the platform. You will find this to be somewhat limited when compared to our UAPI; this is intentional. 

When building your custom integration, you will need acquire the user's API credentials in order to perform most API actions. 

*There are two ways to do this:*

1. Store API credentials for the user locally in your application
2. Use OAuth to gain temporary access only when the user specifically approves it *(recommended)*.

---

**TYPES**

- `DateTime` will be returned as a `String`
- `Decimal` when referring to prices will be returned as a `String`.
