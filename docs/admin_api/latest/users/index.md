---
title: Users
description: User API
---
# Users

## List Users
`GET /api/admin/users`

!!! tip "Include Unprocessed Usage"
    You can optionally pass `?include=balance` to see their unprocessed usage. Unprocessed usage is the amount they have accrued that has not yet been sent to your invoice & payment system.

??? Example "Example"
    ```json
    {
      "users": [
        {
          "id": 1,
          "fname": "John",
          "lname": "Doe",
          "email": "j@doe.com",
          "active": true,
          "is_admin": false,
          "api_key": null,
          "api_version": 0,
          "external_id": null,
          "currency": "USD",
          "confirmed_at": "2020-06-09T18:51:59.142Z",
          "confirmation_sent_at": null,
          "last_request_at": "2020-10-15T05:49:16.258Z",
          "last_sign_in_at": "2020-10-15T05:08:36.974Z",
          "current_sign_in_at": "2020-10-15T05:45:55.042Z",
          "sign_in_count": 50,
          "reset_password_sent_at": null,
          "locked_at": null,
          "failed_attempts": 0,
          "address1": null,
          "address2": null,
          "city": null,
          "state": null,
          "zip": null,
          "country": "US",
          "vat": null,
          "labels": {},
          "created_at": "2020-06-09T18:51:59.145Z",
          "updated_at": "2020-10-15T05:49:16.139Z",
          "security_keys": [],
          "billing_plan": {
            "id": 1,
            "name": "default"
          },
          "user_group": {
            "id": 1,
            "name": "default"
          },
          "external_integrations": [],
          "currency_symbol": "$",
          "current_sign_in_ip": "127.0.0.1",
          "last_sign_in_ip": "127.0.0.1"
        }
      ]
    }
    ```

## View User
`GET /api/admin/users/{user_id}`

!!! tip "Include Unprocessed Usage"
    You can optionally pass `?include=balance` to see their unprocessed usage. Unprocessed usage is the amount they have accrued that has not yet been sent to your invoice & payment system.

In addition to querying a user by their `user_id`, you may also load a user by the following:

<table>
<thead>
  <tr>
    <th>Attribute</th>
    <th>Query Param</th>
    <th>Example</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><code>email</code></td>
    <td>
      <code>find_by_email</code>
    </td>
    <td>
      <code>/api/admin/users/{Base64.encode64('john@doe.com')}?find_by_email=true</code>
    </td>
  </tr>
  <tr>
    <td><code>external_id</code></td>
    <td>
      <code>find_by_external_id</code>
    </td>
    <td>
      <code>/api/admin/users/{some-external-id}?find_by_external_id=true</code>
    </td>
  </tr>
  <tr>
    <td>WHMCS Service ID</td>
    <td>
      <code>find_by_label=whmcs_service_id</code>
    </td>
    <td>
      <code>/api/admin/users/{whmcs-service-id}?find_by_label=whmcs_service_id</code>
    </td>
  </tr>
</tbody>
</table>

??? Example "Example"
    ```json
    {
      "user": {
        "id": 13,
        "fname": "Jane",
        "lname": "Doe",
        "email": "jane@email.net",
        "phone": "",
        "active": true,
        "is_admin": false,
        "api_key": null,
        "api_version": 0,
        "external_id": "",
        "currency": "USD",
        "confirmed_at": "2020-10-15T05:49:07.263Z",
        "confirmation_sent_at": null,
        "last_request_at": "2021-03-01T23:11:08.172Z",
        "last_sign_in_at": "2021-03-01T23:35:20.304Z",
        "current_sign_in_at": "2021-03-01T23:35:37.264Z",
        "sign_in_count": 102,
        "reset_password_sent_at": null,
        "locked_at": null,
        "failed_attempts": 0,
        "address1": "",
        "address2": "",
        "city": "",
        "state": "",
        "zip": "",
        "country": "US",
        "vat": null,
        "company_name": "",
        "run_rate": "0.0",
        "labels": {},
        "created_at": "2020-10-15T05:49:07.272Z",
        "updated_at": "2021-03-01T23:35:37.265Z",
        "security_keys": [],
        "billing_plan": {
          "id": 1,
          "name": "default"
        },
        "user_group": {
          "id": 1,
          "name": "default"
        },
        "external_integrations": [],
        "currency_symbol": "$",
        "current_sign_in_ip": "127.0.0.1",
        "last_sign_in_ip": "127.0.0.1",
        "services": {
          "deployments": 1,
          "containers": 1,
          "container_services": 1,
          "container_images": 0,
          "container_registries": 0,
          "dns_zones": 0
        }
      }
    }
    ```

## Create User
`POST /api/admin/users`

!!! tip ""
    We also have a non-admin [endpoint](https://demo.computestacks.net/documentation/api#operation/User-create){: target="_blank" } for creating users.

<table>
<tbody>
  <tr>
    <td><b>User Email Address</b></td>
    <td>
      While we require a unique, and valid, email address, you may elect to have it only valid in terms of syntax, not deliverability. If you pass the option <code>"skip_email_confirm": true</code> in your json request, we will set the email as valid and not send a confirmation email.
    </td>
  </tr>
  <tr>
    <td><b>External ID</b></td>
    <td>
      All users have an <code>external_id</code> field, which is also visible in the Administrator. You're able to use this for your integration and store a value to help identify this user in your system.
    </td>
  </tr>
    <tr>
    <td><b>Labels</b></td>
    <td>
      Users have a key value label section that you can use to store additional details about the user. When viewing the user, the field will be <code>labels</code>, however when creating the user, please use the parameter <code>merge_labels</code>.
    </td>
  </tr>
</tbody>
</table>

??? Example "Example"
    ```json
    {
      "user": {
        "skip_email_confirm": true, # Optional, otherwise they will get an email asking them to confirm their account.
        "external_id": "", # A field you may use for your own purposes to store a unique id
        "fname": "", # required
        "lname": "", # required
        "email": "", # required. Must be unique in our system! If you skip email confirmation, it does not need to be a real email account.
        "password": "", # required
        "password_confirmation": "", # required
        "address1": "",
        "address2": "",
        "city": "",
        "state": "",
        "zip": "", # postal code
        "country": "",
        "phone": "",
        "user_group_id": "", # blank will use the default user group.
        "merge_labels": [
          {
            "key": "value"
          }
        ]
      }
    }
    ```

??? note "Additional User Fields"

    Field            | Type    | Notes
    -----------------|---------|---------------------------------------------------------------------------
    `active`         | Boolean | Suspended, or un-suspended
    `is_admin`       | Boolean | Grant admin access to this user
    `currency`       | String  | Must be a 3-digit code, like `EUR` or `USD`.
    `bypass_billing` | Boolean | Whether or not billing data should be processed by any billing integration
    `company_name`   | string  |
    `locale`         | string  | Their language in 2-digit format, examples: `en`, `fr`, `de`.

??? example "Example"
    ```json
    {
      "id": 100,
      "fname": "John",
      "lname": "Doe",
      "email": "j@doe.local",
      "active": true,
      "is_admin": false,
      "external_id": "",
      "currency": "USD",
      "confirmed_at": "2020-10-15T05:49:07.263Z",
      "confirmation_sent_at": null,
      "last_request_at": "2021-03-01T23:11:08.172Z",
      "last_sign_in_at": "2021-03-01T22:17:10.344Z",
      "current_sign_in_at": "2021-03-01T23:27:37.728Z",
      "sign_in_count": 0,
      "reset_password_sent_at": null,
      "locked_at": null,
      "failed_attempts": 0,
      "address1": "",
      "address2": "",
      "city": "",
      "state": "",
      "zip": "",
      "country": "US",
      "created_at": "2020-10-15T05:49:07.272Z",
      "updated_at": "2021-03-01T23:27:37.729Z",
      "security_keys": [],
      "billing_plan": {
        "id": 1,
        "name": "default"
      },
      "user_group": {
        "id": 1,
        "name": "default"
      },
      "external_integrations": [],
      "currency_symbol": "$",
      "current_sign_in_ip": "127.0.0.1",
      "last_sign_in_ip": "127.0.0.1"
    }
    ```

## Generate API Credentials
`POST /api/users/{user_id}/api_credentials`

Generate basic auth credentials for this user.

```json
{
  "api_credential": {
    "name": "" # This will be visible in the user's profile.
  }
}
```

??? example "Response"
    ```json
    {
      "api_credential": {
        "id": 0,
        "username": "",
        "password": ""
      }
    }
    ```

## Generate SSO Token
`POST /api/users/{user_id}/user_sso`

This can be used in conjunction with a custom registration process. After you create their user account, you can then request a SSO token and include that in the url: `https://myportal.com/?username={email}&token={token}`.

You should perform this token and redirect all in a single request; the token will expire in less than 1 minute.

??? example "Response"
    ```json
    {
      "username": "j@j.local,
      "token": "TOKEN",
      "expires": "2021-03-01T23:36:57.214Z"
    }
    ```

## Suspend User
`POST /api/users/{user_id}/suspension`

This will stop all their containers and prevent them from using ComputeStacks.

## Unsuspend User
`DELETE /api/users/{user_id}/suspension`

