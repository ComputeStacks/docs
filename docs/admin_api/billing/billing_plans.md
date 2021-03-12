---
title: Billing Plans
description: Billing Plans API
---
# Billing Plans

## List All Billing Plans

`GET` `/api/admin/billing_plans`

??? abstract "Schema"
    * `billing_plans`: Array
        * `id`: Integer
        * `name`: String
        * `user_groups`: Array
            * `id`: Integer
            * `name`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Billing Plan

`GET /api/admin/billing_plans/{id}`

??? abstract "Schema"
    * `billing_plans`: Array
        * `id`: Integer
        * `name`: String
        * `user_groups`: Array
            * `id`: Integer
            * `name`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `billing_resources`: Array
            * `id`: Integer
            * `external_id`: String
            * `product`: Object
                * `id`: Integer
                * `label`: String
                * `resource_kind`: String - package, resource
                * `unit`: Integer
                * `unit_type`: String - GB, MB, Core, etc...
                * `external_id`: String
                * `package`: Object
                    * `id`: Integer
                    * `cpu`: Number
                    * `memory`: Integer
                    * `storage`: Integer
                    * `bandwidth`: Integer
                    * `local_disk`: Integer
                    * `memory_swap`: Integer
                    * `memory_swappiness`: Integer
                    * `backup`: Integer
            * `billing_phases`: Array
                * `id`: Integer
                * `phase_type`: String - trial, discount, or final
                * `duration_unit`: for trial, discount only - hours, days, months, years
                * `duration_qty`: for trial, discount only - how many units of duration_unit.
                * `billing_resource_prices`: Array
                    * `id`: Integer
                    * `currency`: String - 3-letter currency (USD, EUR)
                    * `max_qty`: Number - set to `null` for unlimited. Otherwise, this is the max qty for the price. (used with tiered pricing)
                    * `price`: Number
                    * `regions`: Array
                        * `id`: Integer
                        * `name`: String

## Create Billing Plan

`POST /api/admin/billing_plans`

??? abstract "Schema"
    * `billing_plan`
        * `name`: String
        * `user_group_ids`: Array - optionally link to user groups.
        * `clone`: Integer - the ID of another billing plan to clone

## Update Billing Plan

`PATCH /api/admin/billing_plans/{id}`

??? abstract "Schema"
    * `billing_plan`
        * `name`: String
        * `user_group_ids`: Array - Omit this field if you do not want to change existing values.

## Delete Billing Plan

`DELETE /api/admin/billing_plans/{id}`

This will fail if this is currently assigned to any user groups.
