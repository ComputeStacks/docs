# Locations API

## List Locations

`GET /api/locations`

**OAuth AuthorizationRequired**: `project_read`

??? abstract "schema"
    * `locations`: Array
        * `id`: Integer
        * `name`: String
        * `regions`: Array
            * `id`: Integer
            * `name`: String


## Show Location

`GET /api/locations/{id}`

**OAuth AuthorizationRequired**: `project_read`

??? abstract "schema"
    * `location`: Object
        * `id`: Integer
        * `name`: String
        * `regions`: Array
            * `id`: Integer
            * `name`: String
