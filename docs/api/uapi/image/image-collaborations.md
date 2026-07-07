# Image Collaborations

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

## List All Collaborators

`GET /api/container_images/{container-image-id}/collaborators`

**OAuth Authorization Required**: `images_read`

??? abstract "Schema"
    - `collaborations`: Array
        - `id`: Integer
        - `collaborator`: Object
            - `id`: Integer
            - `email`: String
            - `full_name`: String

---

## View Collaborator

`GET /api/container_images/{container-image-id}/collaborators/{id}`

**OAuth Authorization Required**: `images_read`

??? abstract "Schema"
    - `collaboration`: Object
        - `id`: Integer
        - `image`: Object
            - `id`: Integer
            - `name`: String
    - `collaborator`: Object
        - `id`: Integer
        - `email`: String
        - `full_name`: String
    - `resource_owner`: Object
        - `id`: Integer
        - `email`: String
        - `full_name`: String

---

## Create Collaborator Request

`POST /api/container_images/{container-image-id}/collaborators`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `collaborator`: Object
        - `user_email`: String

---

## Remove Collaborator

`DELETE /api/container_images/{container-image-id}/collaborators/{id}`

**OAuth Authorization Required**: `images_write`
