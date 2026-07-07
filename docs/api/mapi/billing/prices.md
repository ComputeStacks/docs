# Prices

- [Billing Plans](billing-plans.md)
- [Billing Phases](billing-phases.md)
- [Prices](prices.md)
- [Products](products.md)
- [Resources](resources.md)

---

## List All Prices

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{billing_phase_id}/billing_resource_prices`

??? abstract "Schema"
    - `billing_resource_prices`: Array
        - `id`: Integer
        - `billing_phase_id`: Integer
        - `billing_resource_id`: Integer
        - `currency`: String
        - `max_qty`: Decimal
        - `price`: Decimal
        - `term`: String | `hour`, `month`
        - `regions`: Array
            - `id`: Integer
            - `name`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View Price

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{billing_phase_id}/billing_resource_prices/{id}`

??? abstract "Schema"
    - `billing_resource_price`: Object
        - `id`: Integer
        - `billing_phase_id`: Integer
        - `billing_resource_id`: Integer
        - `currency`: String
        - `max_qty`: Decimal
        - `price`: Decimal
        - `term`: String | `hour`, `month`
        - `regions`: Array
            - `id`: Integer
            - `name`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Update Price

`PATCH /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{billing_phase_id}/billing_resource_prices/{id}`

??? abstract "Schema"
    - `billing_resource_price`: Object
        - `currency`: String
        - `max_qty`: Decimal
        - `price`: Decimal
        - `region_ids`: Array | An array of `Region.Ids`

---

## Create Price

`POST /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{billing_phase_id}/billing_resource_prices`

??? abstract "Schema"
    - `billing_resource_price`: Object
        - `currency`: String
        - `max_qty`: Decimal
        - `price`: Decimal
        - `region_ids`: Array | An array of `Region.Ids`

---

## Delete Price

`DELETE /api/admin/billing_plans/{billing_plan_id}/billing_resources/{billing_resource_id}/billing_phases/{billing_phase_id}/billing_resource_prices/{id}`
