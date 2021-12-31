# Load Balancers API

## List your load balancers

`GET /api/load_balancers`

**OAuth AuthorizationRequired**: `projects_read`

?? abstract "schema"
    * `load_balancers`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `public_ip`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Load Balancer

`GET /api/load_balancers/{id}`

**OAuth AuthorizationRequired**: `projects_read`

?? abstract "schema"
    * `load_balancer`: Object
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `public_ip`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
