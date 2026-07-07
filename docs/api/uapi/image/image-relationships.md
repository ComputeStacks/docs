# Image Relationships

[IMAGES](index.md)

- [Collaborations](image-collaborations.md)
- [Environmental Param](image-environmental-params.md)
- [Host Entry](image-host-entry.md)
- [Ingress Params](image-ingress-parameters.md)
- [Image Providers](image-ingress-parameters.md)
- [Relationships](image-relationships.md)
- [Setting Params](image-setting-params.md)
- [Image Variants](image-variants.md)
- [Volumes](image-volumes.md)

---

## List all image relationships

`GET /api/container_images/{container-image-id}/image_relationships`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `image_relationships`: Array
        - `container_image_id`: Integer
        - `requires_container_id`: Integer
        - `default_variant_id`: Integer | Override the default variant for the specified image.
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Show a container image relationship

`GET /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `image_relationship`: Object
        - `container_image_id`: Integer
        - `requires_container_id`: Integer
        - `default_variant_id`: Integer | Override the default variant for the specified image.
        - `created_at`: DateTime

---

## Update a container image relationship

`PATCH /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `image_relationship`: Object
        - `requires_container_id`: Integer
        - `default_variant_id`: Integer | Override the default variant for the specified image.

---

## Create a container image relationship

`POST /api/container_images/{container-image-id}/image_relationships`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `image_relationship`: Object
        - `requires_container_id`: Integer
        - `default_variant_id`: Integer | Override the default variant for the specified image.

---

## Delete a container image relationship

`DELETE /api/container_images/{container-image-id}/image_relationships/{id}`

**OAuth Authorization Required**: `images_write`
