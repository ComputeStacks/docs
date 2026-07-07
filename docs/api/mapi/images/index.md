# Images

[Image Collections](image-collections.md)

## List all images

`GET /api/admin/container_images`

null user == public (system) image.

---

## View an image

`GET /api/admin/container_images/{id}`

null user == public (system) image.

---

## List All Collaborators

`GET /api/admin/container_images/{container-image-id}/collaborators`

??? abstract "Schema"
    - `collaborations`: Array
        - `id`: Integer
        - `collaborator`: Object
            - `id`: Integer
            - `email`: String
            - `full_name`: String

---

## View Collaborator

`GET /api/admin/container_images/{container-image-id}/collaborators/{id}`

??? abstract "Schema"
    - `collaboration`: Object
        - `id`: String
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

`POST /api/admin/container_images/{container-image-id}/collaborators`

??? abstract "Schema"
    - `collaborator`: Object
        - `user_email`: String
        - `skip_confirmation`: Boolean - Add and activate without email notification.

---

## Manually Pull Container Image

This is only necessary for images that do not belong to a user *(public images)*.

User's custom images that they have configured in ComputeStacks are **automatically pulled on *each* rebuild**.

PULL ALL IMAGE VARIANTS FOR AN IMAGE

`POST /api/admin/container_images/{id}/pull`

PULL A SINGLE IMAGE VARIANT

`POST /api/admin/container_images/{container_image_id}/image_variants/{id}/pull`
