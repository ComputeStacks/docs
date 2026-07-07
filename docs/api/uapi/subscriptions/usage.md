# Usage

## List all usages

`GET /api/subscriptions/#{subscription-id}/billing_usage`

**OAuth authorization required**: `profile_read`

??? abstract "Schema"
    - `billing_usages`: Array
        - `id`: Integer
        - `period_start`: DateTime
        - `period_end`: DateTime
        - `external_id`: String
        - `rate`: Decimal
        - `rate_period`: Integer
            - This value will tell you what term the rate is, and is used to determine the hourly price. For example, if `rate` is an hourly price, `rate_period` will be `1`. If monthly, `rate_period` will be 730. `(rate / rate_period) == hourly rate`
        - `qty`: Decimal
        - `total`: Decimal
        - `processed`: Boolean
        - `processed_on`: DateTime
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `product`: `Object<Product>`
        - `user`: Object
            - `id`: Integer
            - `full_name`: String
            - `email`: String
            - `external_id`: String

---

## View Usage Item

`GET /api/subscriptions/#{subscription-id}/billing_usage/{id}`

**OAuth authorization required**: `profile_read`

??? abstract "Schema"
    - `billing_usage`: Object
        - `id`: Integer
        - `period_start`: DateTime
        - `period_end`: DateTime
        - `external_id`: String
        - `rate`: Decimal
        - `rate_period`: Integer
        - `qty`: Decimal
        - `total`: Decimal
        - `processed`: Boolean
        - `processed_on`: DateTime
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `product`: `Object<Product>`
        - `user`: Object
            - `id`: Integer
            - `full_name`: String
            - `email`: String
            - `external_id`: String
