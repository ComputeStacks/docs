---
title: Usage
Description: Subscription Usage
---
# Subscription Usage

ComputeStacks will automatically aggregate this data at the end of the month. You may elect to receive that data as a webhook, configured under Advanced Settings in the admin. ([more info](../../getting_started/integrations/webhooks.md))

## List Usage Items

Description               | Endpoint
--------------------------|------------------------------------------------------------
**Find via subscription** | `GET /admin/subscriptions/{subscription_id}/billing_usages`
**Find all by user**      | `GET /admin/users/{user_id)/billing_usages`

??? abstract "Schema"
    * `billing_usages`: Array
        * `id`: Integer
        * `period_start`: DateTime
        * `period_end`: DateTime
        * `external_id`: String
        * `rate`: Decimal
        * `qty`: Decimal - Billable QTY (less what would be included in their package)
        * `qty_total`: Decimal - Total QTY recorded
        * `total`: Decimal
        * `processed`: Boolean
        * `processed_on`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `subscription_product`: Object
            * `id`: Integer
            * `external_id`: String
            * `start_on`: DateTime
            * `active`: Boolean
            * `phase_type`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
            * `product`: Object
                * `id`: Integer
                * `label`: String
                * `resource_kind`
                * `unit`: String
                * `unit_type`: String
                * `external_id`: DateTime
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
        * `user`: Object
            * `id`: Integer
            * `full_name`: String
            * `email`: String
            * `external_id`: String
            * `labels`: Object

## View Usage Item

`GET /admin/subscriptions/{subscription_id}/billing_usages/{id}`

??? abstract "Schema"
    * `billing_usages`: Object
        * `id`: Integer
        * `period_start`: DateTime
        * `period_end`: DateTime
        * `external_id`: String
        * `rate`: Decimal
        * `qty`: Decimal - Billable QTY (less what would be included in their package)
        * `qty_total`: Decimal - Total QTY recorded
        * `total`: Decimal
        * `processed`: Boolean
        * `processed_on`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `subscription_product`: Object
            * `id`: Integer
            * `external_id`: String
            * `start_on`: DateTime
            * `active`: Boolean
            * `phase_type`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
            * `product`: Object
                * `id`: Integer
                * `label`: String
                * `resource_kind`
                * `unit`: String
                * `unit_type`: String
                * `external_id`: DateTime
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
        * `user`: Object
            * `id`: Integer
            * `full_name`
            * `email`: String
            * `external_id`: String
            * `labels`: Object

## Delete Usage Item

`DELETE /admin/subscriptions/{subscription_id}/billing_usages/{id}`
