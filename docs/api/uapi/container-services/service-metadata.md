# Service Metadata

## List Container Service Metadata

`GET /api/container_services/{container-service-id}/metadata`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `metadata`: Array
        - `id`: Integer
        - `name`: String
        - `label`: String
        - `param_type`: String
        - `decrypted_value`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View Metadata

`GET /api/container_services/{container-service-id}/metadata/{id}`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `metadata`: Object
        - `id`: Integer
        - `name`: String
        - `label`: String
        - `param_type`: String
        - `decrypted_value`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime
