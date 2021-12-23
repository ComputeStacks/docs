---
title: Resources
description: Resources API
---
# Resources

## List All Resources

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources`

??? abstract "Schema"
    * `billing_resources`: Array
        * `id`: Integer
        * `billing_plan_id`: Integer
        * `external_id`: String
        * `product_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Billing Resource

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`

??? abstract "Schema"
    * `billing_resource`: Object
        * `id`: Integer
        * `billing_plan_id`: Integer
        * `external_id`: String
        * `product_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Edit Billing Resource

`PATCH /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`

??? abstract "Schema"
    * `billing_resource`: Object
        * `billing_plan_id`: Integer
        * `external_id`: String
        * `product_id`: Integer


## Create Billing Resource

`POST /api/admin/billing_plans/{billing_plan_id}/billing_resources`

??? abstract "Schema"
    * `billing_resource`: Object
        * `external_id`: String
        * `product_id`: Integer


## Delete Billing Resource

`DELETE /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`
