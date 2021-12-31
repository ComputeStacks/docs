# Billing Events API

## List Events

`GET /api/subscriptions/{subscription-id}/billing_events`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `billing_events`: Array
        * `id`: Integer
        * `from_status`: Boolean
        * `to_status`: Boolean
        * `from_phase`: `String<trial,discount,final>`
        * `to_phase`: `String<trial,discount,final>`
        * `from_resource_qty`: Integer
        * `to_resource_qty`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `subscription`: `Object<Subscription>`
        * `source_product`: `Object<Product>`
        * `destination_product`: `Object<Product>`


## View Event

`GET /api/subscriptions/{subscription-id}/billing_events/{id}`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `billing_event`: Object
        * `id`: Integer
        * `from_status`: Boolean
        * `to_status`: Boolean
        * `from_phase`: `String<trial,discount,final>`
        * `to_phase`: `String<trial,discount,final>`
        * `from_resource_qty`: Integer
        * `to_resource_qty`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `subscription`: `Object<Subscription>`
        * `source_product`: `Object<Product>`
        * `destination_product`: `Object<Product>`