# Usage API

## List all usages

`GET /api/subscriptions/#{subscription-id}/billing_usage`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `billing_usages`: Array
        * `id`: Integer
        * `period_start`: DateTime
        * `period_end`: DateTime
        * `external_id`: String
        * `rate`: Decimal
        * `qty`: Decimal
        * `total`: Decimal
        * `processed`: Boolean
        * `processed_on`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `product`: `Object<Product>`
        * `user`: Object
            * `id`: Integer
            * `full_name`: String
            * `email`: String
            * `external_id`: String

## View Usage Item

`GET /api/subscriptions/#{subscription-id}/billing_usage/{id}`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `billing_usage`: Object
        * `id`: Integer
        * `period_start`: DateTime
        * `period_end`: DateTime
        * `external_id`: String
        * `rate`: Decimal
        * `qty`: Decimal
        * `total`: Decimal
        * `processed`: Boolean
        * `processed_on`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `product`: `Object<Product>`
        * `user`: Object
            * `id`: Integer
            * `full_name`: String
            * `email`: String
            * `external_id`: String
