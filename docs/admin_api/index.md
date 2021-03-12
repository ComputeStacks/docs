---
title: Overview
description: Admin API
---
# Admin API
Our Administrator API is intentionally limited in what it can do. Anything that can be done by the user, should be. Please see our user [API Documentation](https://demo.computestacks.net/documentation/api){: target="_blank" }.

When building your custom integration, you will need acquire the user's API credentials in order to perform most API actions. There are two ways to do this:

1. Store API credentials for the user locally in your application
2. Use OAuth to gain temporary access only when the user specifically approves it _(recommended)_.

---

!!! note "A note about types"
    * `DateTime` will be returned as a `String`
    * `Decimal` when referring to prices will be returned as a `String`.
