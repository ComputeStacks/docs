# Orders API

## List all orders

`GET /api/orders`

**OAuth AuthorizationRequired**: `order_read`

??? abstract "schema"
    * `orders`: Array
        * `id`: UUID
        * `status`: `String<open,pending,awaiting_payment,processing,cancelled,failed,completed`
        * `project`: Object
            * `id`: Integer
            * `name`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Get a single order

`GET /api/orders/{id}`

**OAuth AuthorizationRequired**: `order_read`

??? abstract "schema"
    * `orders`: Object
        * `id`: UUID
        * `status`: `String<open,pending,awaiting_payment,processing,cancelled,failed,completed`
        * `project`: Object
            * `id`: Integer
            * `name`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Create a new order

`POST /api/orders`

**OAuth AuthorizationRequired**: `order_write`

??? abstract "schema"
    * `order`: Object
        * `project_name`: String
        * `skip_ssh`: Boolean
        * `location_id`: Integer
        * `project_id`: Integer | Only if adding to existing project
        * `containers`: Array
            * `image_id`: Integer
            * `domains`: `Array<String>` | provide an optional list of domains you want added after the order is provisioned.
            * `resources`: Object
                * `package_id`: Integer
            * `params`: Array
                * `key`: String
                * `value`: String
