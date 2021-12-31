# Image Relationships

## List all image relationships

`GET /api/container_images/{container-image-id}/image_relationships`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `image_relationships`: Array
        * `container_image_id`: Integer
        * `requires_container_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Show a container image relationship

`GET /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `image_relationship`: Object
        * `container_image_id`: Integer
        * `requires_container_id`: Integer
        * `created_at`: DateTime

## Update a container image relationship

`PATCH /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `image_relationship`: Object
        * `requires_container_id`: Integer

## Create a container image relationship

`POST /api/container_images/{container-image-id}/image_relationships`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `image_relationship`: Object
        * `requires_container_id`: Integer

## Delete a container image relationship

`DELETE /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_write`

