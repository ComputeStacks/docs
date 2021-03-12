---
title: Subscriptions
Description: Subscription Management
---
# Subscription Management

## List Subscriptions

Description                    | Endpoint
-------------------------------|-------------------------------------------------------------------
**Find All Subscriptions**     | `GET /api/admin/subscriptions`
**Filter By User _or_ Status** | `GET /api/admin/(users/{user_id})/subscriptions/(filter/{filter})`

!!! tip ""
    **filter** can be one of: `active`, `inactive`.


??? abstract "Schema"
    * `subscriptions`: Array
        * `id`: Integer
        * `label`: String
        * `external_id`: String
        * `active`: Boolean
        * `user`: Object
            * `id`: Integer
            * `full_name`: String
            * `email`: String
            * `external_id`: String
            * `labels`: Object


## View Subscription

`GET /api/admin/subscription/{id}`

??? abstract "Schema"
    * `subscription`: Object
        * `id`: Integer
        * `label`: String
        * `external_id`: String
        * `active`: Boolean
        * `run_rate`: Decimal
        * `subscription_products`: Array
            * `id`: Integer
            * `external_id`: String
            * `active`: Boolean
            * `start_on`: DateTime
            * `phase_type`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
            * `product`: Object
                * `id`: Integer
                * `label`: String
                * `resource_kind`: String
                * `unit`: String
                * `unit_type`: String
                * `external_id`: String
                * `created_at`: DateTime
                * `updated_at`: DateTime
                * `package`: Object
                    * `id`: Integer
                    * `cpu`: Decimal
                    * `memory`: Integer
                    * `storage`: Integer
                    * `bandwidth`: Integer
                    * `local_disk`: Integer
                    * `memory_swap`: Integer
                    * `memory_swappiness`: Integer
                    * `backup`: Integer
            * `billing_resource`: Object
                * `id`: Integer
                * `billing_plan_id`: Integer
                * `external_id`: String
        * `container`: Object
            * `id`: Integer
            * `name`: String
            * `req_state`: String
            * `current_state`: String
            * `stats`: Object<cpu: decimal, memory: decimal>
            * `local_ip`: String
            * `public_ip`: String
            * `project_id`: Integer
            * `container_service_id`
            * `project_id`: Integer
            * `created_at`: DateTime
            * `updated_at`: DateTime
            * `links`: Object
                * `container_service`: String
                * `logs`: String
                * `project`: String
            * `region`: Object
                * `id`: Integer
                * `name`: String
            * `node`: Object
                *  `id`: Integer
                * `label`: String
                * `hostname`: String
                * `primary_ip`: String
                * `public_ip`: String
        * `user`: Object
            * `id`: Integer
            * `email`: String
            * `external_id`: String
            * `labels`: Object


## Update Subscription

`PATCH /api/admin/subscriptions/:id`

Use this to upgrade or downgrade an existing service.

Will return a `HTTP 200` if was successful, otherwise you will have a `HTTP 40x` code and a  `{"errors": []}` response.

??? abstract "Schema"
    * `container_service`: Object
        * `product_id`: The new product id
        * `qty`: The _total_ amount of containers you want. For example, if you have 1 container and you want 2, you would set this value to 2.

??? example "Upgrade a product"
    ```json
    {
      "container_service": {
        "product_id": Integer
      }
    }
    ```

??? example "Scale a service up or down"
    ```json
    {
      "container_service": {
        "qty": Integer
      }
    }
    ```

---

## Suspension

For integrations that rely on the subscription as their internal reference, we offer a helper api endpoint to suspend a user via their subscription.

!!! danger ""
    This will suspend the user, not just the subscription.

### Suspend

`POST /api/admin/subscriptions/{subscription_id}/suspension`

### Unsuspend

`DELETE /api/admin/subscriptions/{subscription_id}/suspension`

