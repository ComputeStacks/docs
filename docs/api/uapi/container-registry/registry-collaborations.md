# Registry Collaborations

## List All Collaborators

`GET /api/container_registry/{container-registry-id}/collaborators`

**OAuth authorization required**: `images_read`

??? abstract "Schema"
    - `collaborations`: Array
        - `id`: Integer
        - `collaborator`: Object
            - `id`: Integer
            - `email`: String
            - `full_name`: String

---

## View Collaborator

`GET /api/container_registry/{container-registry-id}/collaborators/{id}`

**OAuth authorization required**: `images_read`

??? abstract "Schema"
    - `collaboration`: Object
        - `id`: Integer
        - `registry`: Object
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

`POST /api/container_registry/{container-registry-id}/collaborators`

**OAuth authorization required**: `images_write`

??? abstract "Schema"
    - `collaborator`: Object
        - `user_email`: String

---

## Remove Collaborator

`DELETE /api/container_registry/{container-registry-id}/collaborators/{id}`

**OAuth authorization required**: `images_write`
