---
title: Overview
description: User API
---
# User API

End-User API Documentation

!!! danger ""
    This is a work in progress! Please also reference our existing [API Documentation](https://demo.computestacks.net/documentation/api){: target="_blank" }.

When building your custom integration, you will need acquire the user's API credentials in order to perform most API actions. There are two ways to do this:

1. Store API credentials for the user locally in your application
2. Use OAuth to gain temporary access only when the user specifically approves it _(recommended)_.

---

!!! note "A note about types"
    * `DateTime` will be returned as a `String`
    * `Decimal` when referring to prices will be returned as a `String`.
