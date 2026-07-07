# Image Providers

Each container image is associated with a *provider* object, which holds any authentication details and URL.

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

## List All Providers

**OAuth Authorization Required**: `images_read`

`GET /api/container_image_providers`

??? abstract "Schema"
    - `container_image_providers`: Array
        - `id`: Integer
        - `name`: String
        - `hostname`: String
        - `is_default`: Boolean
        - `updated_at`: DateTime
        - `created_at`: DateTime

---

## View Image Provider

Show a single Container Image Provider

**OAuth Authorization Required**: `images_read`

`GET /api/container_image_providers/{id}`

??? abstract "Schema"
    - `container_image_providers`: Array
        - `id`: Integer
        - `name`: String
        - `hostname`: String
        - `is_default`: Boolean
        - `updated_at`: DateTime
        - `created_at`: DateTime
