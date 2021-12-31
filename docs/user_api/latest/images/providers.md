# Image Providers

Each container image is associated with a _provider_ object, which holds any authentication details and URL.

## List All Providers

**OAuth Authorization Required**: `images_read`

`GET /api/container_image_providers`

??? abstract "schema"
    * `container_image_providers`: Array
        * `id`: Integer
        * `name`: String
        * `hostname`: String
        * `is_default`: Boolean
        * `updated_at`: DateTime
        * `created_at`: DateTime

## View Image Provider

Show a single Container Image Provider

**OAuth Authorization Required**: `images_read`

`GET /api/container_image_providers/{id}`

??? abstract "schema"
    * `container_image_providers`: Array
        * `id`: Integer
        * `name`: String
        * `hostname`: String
        * `is_default`: Boolean
        * `updated_at`: DateTime
        * `created_at`: DateTime

