# Image Host Entry

Create custom host entries (`/etc/hosts`) that link to other linked images that will be deployed along side this image. This is intended to support backwards compatibility with docker compose.

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

## List all host entries

`GET /api/container_images/{container-image-id}/custom_host_entries`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `host_entries`: Array
        - `hostname`: String
        - `source_image`: Object
            - `id`: Integer
            - `label`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View host entry

`GET /api/container_images/{container-image-id}/custom_host_entries/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `host_entries`: Object
        - `hostname`: String
        - `source_image`: Object
            - `id`: Integer
            - `label`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Update host entry

`PATCH /api/container_images/{container-image-id}/custom_host_entries/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `host_entry`: Object
        - `hostname`: String
        - `source_image_id`: Integer

---

## Create host entry

`POST /api/container_images/{container-image-id}/custom_host_entries`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `host_entry`: Object
        - `hostname`: String
        - `source_image_id`: Integer

---

## Delete host entry

`DELETE /api/container_images/{container-image-id}/custom_host_entries/{id}`

**OAuth Authorization Required**: `images_write`
