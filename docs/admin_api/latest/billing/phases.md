---
title: Phases
description: Phases API
---
# Phases

## List All Billing Phases

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases`

??? abstract "Schema"
    * `billing_phases`: Array
        * `id`: Integer
        * `billing_resource_id`: Integer
        * `phase_type`: String
        * `duration_unit`: String
        * `duration_qty`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Billing Phase

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{id}`

??? abstract "Schema"
    * `billing_phase`: Object
        * `id`: Integer
        * `billing_resource_id`: Integer
        * `phase_type`: String
        * `duration_unit`: String
        * `duration_qty`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Update Billing Phase

`PATCH /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{id}`

??? abstract "Schema"
    * `billing_phase`: Object
        * `phase_type`: String
        * `duration_unit`: String
        * `duration_qty`: Integer

## Create Billing Phase

`POST /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases`

??? abstract "Schema"
    * `billing_phase`: Object
        * `phase_type`: String
        * `duration_unit`: String
        * `duration_qty`: Integer

## Delete Billing Phase

`DELETE /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{id}`

