# Image Variants

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

## Create Image Variant

`POST /api/container_images/{container-image-id}/image_variants`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `image_variant`: Object
        - `label`: String
        - `registry_image_tag`: String | e.g. 'latest'
        - `is_default`: Boolean
        - `version`: Integer | Sorting position in drop down list. Lower = higher in the list
        - `before_migrate`: String | Command to run inside container before moving between versions
        - `after_migrate`: String | Command to run inside container after moving between versions
        - `rollback_migrate: String` | Command to run inside container when the before script fails.
        

---

## Update Image Variant

`POST /api/container_images/{container-image-id}/image_variants`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `image_variant`: Object
        - `label`: String
        - `registry_image_tag`: String | e.g. 'latest'
        - `is_default`: Boolean
        - `version`: Integer | Sorting position in drop down list. Lower = higher in the list
        - `before_migrate`: String | Command to run inside container before moving between versions
        - `after_migrate`: String | Command to run inside container after moving between versions
        - `rollback_migrate: String` | Command to run inside container when the before script fails.

---

## Delete Image Variant

`DELETE /api/container_images/{container-image-id}/image_variants`

**OAuth Authorization Required**: `images_write`
