# Resources

- [Billing Plans](billing-plans.md)
- [Billing Phases](billing-phases.md)
- [Prices](prices.md)
- [Products](products.md)
- [Resources](resources.md)

---

Billing Resources are used to map products, prices, and phases, within a billing plan.

## List All Resources

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources`

??? abstract "Schema"
    - `billing_resources`: Array
        - `id`: Integer
        - `billing_plan_id`: Integer
        - `external_id`: String
        - `prorate`: Boolean
        - `product_id`: Integer
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View Billing Resource

`GET /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`

??? abstract "Schema"
    - `billing_resource`: Object
        - `id`: Integer
        - `billing_plan_id`: Integer
        - `external_id`: String
        - `prorate`: Boolean
        - `product_id`: Integer
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Edit Billing Resource

`PATCH /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`

??? abstract "Schema"
    - `billing_resource`: Object
        - `billing_plan_id`: Integer
        - `external_id`: String
        - `product_id`: Integer
        - `prorate`: Boolean

---

## Create Billing Resource

`POST /api/admin/billing_plans/{billing_plan_id}/billing_resources`

??? abstract "Schema"
    - `billing_resource`: Object
        - `external_id`: String
        - `product_id`: Integer
        - `prorate`: Boolean

---

## Delete Billing Resource

`DELETE /api/admin/billing_plans/{billing_plan_id}/billing_resources/{id}`
