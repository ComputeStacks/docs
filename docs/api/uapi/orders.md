# Orders

## List all orders

`GET /api/orders`

**OAuth authorization required**: `order_read`

??? abstract "Schema"
    - `orders`: Array
        - `id`: UUID
        - `status`: `String<open,pending,awaiting_payment,processing,cancelled,failed,completed`
        - `project`: Object
            - `id`: Integer
            - `name`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Get a single order

`GET /api/orders/{id}`

**OAuth authorization required**: `order_read`

??? abstract "Schema"
    - `orders`: Object
        - `id`: UUID
        - `status`: `String<open,pending,awaiting_payment,processing,cancelled,failed,completed`
        - `project`: Object
            - `id`: Integer
            - `name`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Create a new order

`POST /api/orders`

**OAuth authorization required**: `order_write`

??? abstract "Schema"
    - `order`: Object
        - `project_name`: String
        - `skip_ssh`: Boolean
        - `location_id`: Integer
        - `project_id`: Integer | Only if adding to existing project
        - `containers`: Array
            - `image_variant_id`: Integer
            - `domains`: `Array<String>` | provide an optional list of domains you want added after the order is provisioned.
            - `resources`: Object
                - `package_id`: Integer
            - `params`: Array
                - `key`: String
                - `value`: String
