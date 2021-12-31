# Environmental Params

## List all environmental parameters

`GET /api/container_images/{container-image-id}/env_params`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `env_params`: Array
        * `name`: String
        * `label`: String
        * `param_type`: `String<static,variable>`
        * `env_value`: String | when param_type == variable
        * `static_value`: String | when param_type == static
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View environmental parameter

`GET /api/container_images/{container-image-id}/env_params/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `env_param`: Object
        * `name`: String
        * `label`: String
        * `param_type`: `String<static,variable>`
        * `env_value`: String | when param_type == variable
        * `static_value`: String | when param_type == static
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Update an environmental parameter

`PATCH /api/container_images/{container-image-id}/env_params/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `env_param`: Object
        * `name`: String
        * `label`: String
        * `param_type`: `String<static,variable>`
        * `env_value`: String
        * `static_value`: String

## Create an environmental parameter

`POST /api/container_images/{container-image-id}/env_params`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `env_param`: Object
        * `name`: String
        * `label`: String
        * `param_type`: `String<static,variable>`
        * `env_value`: String
        * `static_value`: String

## Destroy an env param

`DELETE /api/container_images/{container-image-id}/env_params/{id}`

**OAuth Authorization Required**: `images_write`
