# Image Collections

## List all image collections

`GET /api/image_collections`

**OAuth Authorization Required**: `images_read`

??? abstract "Schema"
    - `image_collections`: Array
        - `id`: Integer
        - `label`: String
        - `active`: Boolean
        - `sort`: Integer
        - `container_images`: `Array<ContainerImage>`
        - `created_at`: DateTime
        - `updated_at`: DateTime
