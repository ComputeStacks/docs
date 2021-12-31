# User API

## View your user account

`GET /api/users`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `user`: Object
        * `id`: Integer
        * `fname`: String
        * `lname`: String
        * `email`: String
        * `phone`: String
        * `address1`: String
        * `address2`: String
        * `city`: String
        * `company_name`: String
        * `country`: String
        * `timezone`: String
        * `currency`: Object
            * `code`: String
            * `symbol`: String
        * `c_sftp_pass`: Boolean - Enable SFTP Auth on all new projects.
        * `zip`: String
        * `vat`: String
        * `state`: String
        * `locale`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `billing_plan`: Object
            * `id`: Integer
            * `name`: String
        * `services`: Object
            * `projects`: Integer
            * `containers`: Integer
            * `container_services`: Integer
            * `container_images`: Integer
            * `container_registries`: Integer
            * `dns_zones`: Integer
        * `quota`: Object
            * `{{kind}}`: Object
                * `current`: Integer
                * `quota`: Integer
                * `is_over`: Boolean
                * `available`: Integer
        * `unprocessed_usage`: Decimal | The amount the user has accrued, but not yet transferred to the billing system for billing.

??? example "Example"
    ```json
    {
      "user": {
        "id": 1,
        "fname": "John",
        "lname": "Doe",
        "email": "john@example.com",
        "phone": null,
        "address1": null,
        "address2": null,
        "city": null,
        "company_name": null,
        "country": "US",
        "timezone": "America/Los_Angeles",
        "currency": {
          "code": "USD",
          "symbol": "$"
        },
        "zip": null,
        "vat": null,
        "state": null,
        "locale": "en",
        "created_at": "2019-04-04T07:36:50.637Z",
        "updated_at": "2019-09-19T19:16:07.155Z",
        "billing_plan": {
          "id": 1,
          "name": "default"
        },
        "services": {
          "projects": 0,
          "containers": 0,
          "container_services": 0,
          "container_images": 1,
          "container_registries": 0,
          "dns_zones": 0
        },
        "quota": {
          "containers": {
            "current": 0,
            "quota": 250,
            "is_over": false,
            "available": 250
          },
          "cr": {
            "current": 0,
            "quota": 20,
            "is_over": false,
            "available": 20
          },
          "dns_zones": {
            "current": 0,
            "quota": 250,
            "is_over": false,
            "available": 250
          }
        },
        "unprocessed_usage": 0.0
      }
    }
    ```

## Update your user account

`PATCH /api/users`

**OAuth AuthorizationRequired**: `profile_update`

??? abstract "schema"
    * `user`: Object
        * `fname`: String
        * `lname`: String
        * `email`: String
        * `locale`: String | locale code (example: `en`)
        * `city`: String
        * `state`: String
        * `zip`: String
        * `c_sftp_pass`: Boolean
        * `country`: String | Should be in the 2 digit format, e.g. US, CA, NL, etc.
        * `address1`: String
        * `address2`: String
        * `company_name`: String
        * `phone`: String
        * `currency`: String
        * `merge_labels`: Object


## Create New User

`POST /api/users`

**OAuth AuthorizationRequired**: `register`

This is a special endpoint for use in conjunction with our embeddable interface.
Users are not expected to be able to login directly after signup.

* Only available using the `register` scope.
* This will automatically generate api credentials
* This will not send an email confirmation
* If no email is provided, or if the email is already in use, this will generate a unique email address

??? abstract "schema"
    * `user`: Object
        * `fname`: String (required)
        * `lname`: String (required)
        * `email`: String
        * `locale`: String | locale code (example: `en`)
        * `city`: String
        * `state`: String
        * `zip`: String
        * `c_sftp_pass`: Boolean
        * `country`: String | Should be in the 2 digit format, e.g. US, CA, NL, etc.
        * `address1`: String
        * `address2`: String
        * `company_name`: String
        * `phone`: String
        * `currency`: String
        * `merge_labels`: Object
        * `provider_server`: String (required) | The url or unique server name of the provider's server. This is used to scope the username.
        * `provider_username`: String (required) | the user's username on the server.

??? example "Example"
    ```json
    {
      "user": {
        "fname":  "string",
        "lname":  "string",
        "email":  "string",
        "locale": "string",
        "api":    {
          "username": "string",
          "password": "string"
        },
        "labels": {
          "key":       "value",
          "other_key": {
            "key": "value"
          }
        }
      }
    }
    ```