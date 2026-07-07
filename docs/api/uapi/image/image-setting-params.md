# Image Setting Params

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

## List all image settings

`GET /api/container_images/{container-image-id}/setting_params`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `setting_params`: Array
        - `id`: Integer
        - `name`: String
        - `label`: String
        - `param_type`: `String<password,static>`
        - `value`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View a single setting

`GET /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `setting_param`: Object
        - `id`: Integer
        - `name`: String
        - `label`: String
        - `param_type`: `String<password,static>`
        - `value`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Update a setting

`PATCH /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `setting_param`: Object
        - `label`: String
        - `name`: String
        - `param_type`: `String<password,static>`
        - `value`: String

---

## Create a setting

`POST /api/container_images/{container-image-id}/setting_params`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `setting_param`: Object
        - `label`: String
        - `name`: String
        - `param_type`: `String<password,static>`
        - `value`: String

---

## Delete a setting

`DELETE /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_write`
