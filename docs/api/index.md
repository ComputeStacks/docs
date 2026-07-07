# API Reference

ComputeStacks has two API implementations. Both are currently at **version 80** (v8.0), the latest release.

<div class="grid cards" markdown>

-   __User API (UAPI)__

    ---

    The standard interface for building applications and integrations on behalf of a user. Access is scoped to a single account, via Basic Auth or OAuth2.

    [:octicons-arrow-right-24: User API (v8.0)](uapi/index.md)

-   __Manage API (MAPI)__

    ---

    Super-user access to the platform for provider-level automation. Intentionally more limited than the UAPI.

    [:octicons-arrow-right-24: Manage API (v8.0)](mapi/index.md)

</div>

!!! tip
    Requesting a specific API version is optional — omit the version and the current release is used. See [versioning](uapi/index.md#versioning) for details.
