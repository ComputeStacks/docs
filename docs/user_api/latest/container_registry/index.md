# Container Registry API

## List all Container Registries

`GET /api/container_registry`

**OAuth Authorization Required**: `images_read`

??? abstract "schema"
    * `container_registries`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `status`: String
        * `endpoint`: String | url and port
        * `username`: String
        * `password`: String
        * `images`: Array
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Container Registry

`GET /api/container_registry/{id}`

**OAuth Authorization Required**: `images_read`

??? abstract "schema"
    * `container_registry`: Object
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `status`: String
        * `endpoint`: String | url and port
        * `username`: String
        * `password`: String
        * `images`: Array
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Update Container Registry

`PATCH /api/container_registry/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `container_registry`: Object
        * `label`: String


## Create Container Registry

`POST /api/container_registry`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `container_registry`: Object
        * `label`: String


## Delete Container Registry

`DELETE /api/container_registry/{id}`

**OAuth Authorization Required**: `images_write`
