# Service Metadata

## List Container Service Metadata

`GET /api/container_services/{container-service-id}/metadata`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `metadata`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `param_type`: String
        * `decrypted_value`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Metadata

`GET /api/container_services/{container-service-id}/metadata/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `metadata`: Object
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `param_type`: String
        * `decrypted_value`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime