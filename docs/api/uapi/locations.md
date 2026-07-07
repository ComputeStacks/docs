# Locations

## List Locations

`GET /api/locations`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `locations`: Array
        - `id`: Integer
        - `name`: String
        - `regions`: Array
            - `id`: Integer
            - `name`: String

---

## Show Location

`GET /api/locations/{id}`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `location`: Object
        - `id`: Integer
        - `name`: String
        - `regions`: Array
            - `id`: Integer
            - `name`: String
