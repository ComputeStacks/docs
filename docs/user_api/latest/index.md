---
title: Latest
description: Latest API Version
---
# End-User API Documentation

When building your custom integration, you will need acquire the user's API credentials in order to perform most API actions. There are two ways to do this:

1. Store API credentials for the user locally in your application
2. Use OAuth to gain temporary access only when the user specifically approves it _(recommended)_.

---

!!! note "A note about types"
    * `DateTime` will be returned as a `String`
    * `Decimal` when referring to prices will be returned as a `String`.
    * `Array<ContainerImage>` means it returns the same result as the primary REST interface. For example, `/api/projects/{project-id}/images` would return an array of `/api/container_images`

## Authentication

### Basic Auth

Using basic authentication is the easiest way to get started with our API. However, keep in mind that the API credentials that are generated for basic authentication give full access to your entire account, just as if you were logged into the control panel.

If you plan to distribute an application using our API, or allow more than one user access to the tool you're building, please use OAuth. This is the more secure alternative as it allows you to restrict what your application can do while authenticated to your account.

#### Invalidating tokens / api keys

When you generate a new api key in ComputeStacks, any previously generated tokens will be immediately invalidated.

### OAuth2

Our OAuth2 endpoint supports the following [grant types](https://oauth.net/2/grant-types/):

* `Authorization Code`
* `Password`
  * Same API credentials used `basic auth`, _not_ your normal login credentials.
* `Client Credentials`
  * Only has access to API methods with the `public` scope. No user data.
* `Refresh Token`
  * Only available via the `Authorization Code` grant type.

[Scopes](https://oauth.net/2/scope/) allow you to restrict what access your OAuth application has access to. When your users authenticate, they will be shown what access you're requesting, so please only request access to the scopes you will actually need.

Endpoint Type     | URL
------------------|-----------------------
Token URL         | `/api/oauth/token`
Authorization URL | `/api/oauth/authorize`

#### Available Scopes

* `public`
* `images_read`
* `images_write`
* `dns_read`
* `dns_write`
* `order_read`
* `order_write`
* `profile_read`
* `profile_write`
* `register`
* `project_read`
* `project_write`

## Pagination

All collection requests will be paginated using the headers `Per-Page` and `Total`. To set these values in your request, pass the URL params `page=` and `per-page=`.

## Versioning

You may optionally request a specific API version by modifying the Accept header with: `application/json; api_version=60`, where `60` is the version of the API.

If you omit this value, then the current version will be used.

Current version: 60

If you pass an unsupported API version, you will receive an HTTP status code of `422 (UNPROCESSABLE ENTITY)`

### Get API Version

`GET /version`

??? abstract "Schema"
    * `version`: String
    * `api_latest_version`: String
    * `api_available_versions`: `Array<Integer>`


## Successful Responses

The following HTTP codes may be returned to denote a successful response:

* 200 OK
* 201 Created
* 202 Accepted

## Error Handling

The following error codes may be returned. If any error messages exist, they will be passed to the `{errors: []}` field.

* `400 Bad Request`
* `401 Unauthorized` Basic auth will return this if your credentials are invalid
* `403 Forbidden` OAuth will return this for invalid tokens
* `404 Not Found`
* `408 Request Timeout`
* `422 Unprocessable Entity`
* `500 Internal Server Error`
