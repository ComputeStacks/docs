---
title: API Only
description: Create a custom onboarding process
---
# Creating A Custom Onboarding Process

**Example Scenario**
<br>
You have a custom control panel, and you wish to automate the onboarding of a new user, and placing their order without using the controller UI.
**Overview**
<br>
In this guide, we will:

* Create a user
* Provision a new project

---

## Create User

!!! danger ""
    You will need to be an administrator to perform these api calls.

The first step is to create the user in ComputeStacks. We provide a 3 different mechanisms to aid with your integration:

**User Email Address**
While we require a unique, and valid, email address, you may elect to have it only valid in terms of syntax, not deliverability. If you pass the option `"skip_email_confirm": true` in your json request, we will set the email as valid and not send a confirmation email. 

**External ID**
All users have an `external_id` field, which is also visible in the Administrator. You're able to use this for your integration and store a value to help identify this user in your system

**Labels**
Users have a key value label section that you can use to store additional details about the user. When viewing the user, the field will be `labels`, however when creating the user, please use the parameter `merge_labels`.

`POST /api/admin/users`
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
    `active`         | Boolean | Suspended, or un-suspended<
    `currency`       | String  | Must be a 3-digit code, like `EUR` or `USD`.
    `bypass_billing` | Boolean | Whether or not billing data should be processed by any billing integration
    `company_name`   | string  |
    `locale`         | string  | Their language in 2-digit format, examples: `en`, `fr`, `de`.


### Retrieve API Credentials

Now that you have created the user, you can use the returned ID to generate API Credentials _(Basic Auth)_

`POST /api/users/{user_id}/api_credentials`

```json
{
  "api_credential": {
    "name": ""
  }
}
```

This will return the following:

```json
{
  "api_credential": {
    "id": 0,
    "username": "",
    "password": ""
  }
}
```

You may now use these api credentials to perform the next steps, as the user.

## Get Available Products

`GET /products`

Will return:

```json
{
  "products": [
    {
      "id": 1,
      "name": "small",
      "price": "0.0",
      "term": "hour",
      "cpu": "1.0",
      "memory": 256, # MB
      "storage": 5, # GB
      "bandwidth": 100, # GB
      "backup": 0, # GB
      "local_disk": 5, # GB
      "memory_swap": null, # null == no swap to disk, same as 0.
      "memory_swappiness": null, # null == default, which i believe is 60.
      "region": 1
    }
  ]
}
```

## Build Order

### Create The Order

`POST /api/order`

```json
{
  "order": {
    "project_name": "my test project",
    "location_id": 0, # /api/locations
    "containers": [
      {
        "image_id": 0,
        "resources": { "product_id": 0 },

        # You can get this from /api/container_images/{image_id}
        # They key is the field name under 'container_image_setting_params'.
        "params": [
          {
            "key": "",
            "value": ""
          }
        ],
        "domains": [] # exmple.com, www.example.com...
      }
    ]
  }
}
```

This will return

```json
{
  "order": {
    "id": "f5a34c0f-e9e2-45e0-9bba-d342d12517fc",
    "redirect_url": null, # not applicable for you

    # This will be the public IP of the LB. We use this in our cPanel integration to
    # set the A record for the domain hosted by cPanel, while the project is being provisioned.
    "load_balancer_ip": "192.168.1.10"
  }
}
```

### Locate the project

The project is created in the background, so we won't be able to return it immediately. You will need to take the Order ID and query us for the project:

`GET /api/order/{id}`

Keep checking this until you see `"status": "completed"` and you have `order.project.id`.

```json
{
  "order": {
    "id": "f5a34c0f-e9e2-45e0-9bba-d342d12517fc",
    "status": "completed",
    "order_data": {
      ...
    },
    "created_at": "2021-03-01T22:32:46.080Z",
    "updated_at": "2021-03-01T22:32:48.125Z",
    "project": {
      "id": 85,
      "name": "my test project"
    },
    "location": {
      "id": 1,
      "name": "demo"
    }
  }
}
```

You can now use the project ID to manage the project as normal.

