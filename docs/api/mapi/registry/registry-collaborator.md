# Registry: Collaborator

## List All Collaborators

`GET /api/admin/container_registry/{container-registry-id}/collaborators`

**Schema**

- `collaborations`: Array
    - `id`: Integer
    - `collaborator`: Object
        - `id`: Integer
        - `email`: String
        - `full_name`: String

## View Collaborator

`GET /api/admin/container_registry/{container-registry-id}/collaborators/{id}`

**Schema**

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

## Create Collaborator Request

`POST /api/admin/container_registry/{container-registry-id}/collaborators`

**Schema**

- `collaborator`: Object
    - `user_email`: String
    - `skip_confirmation`: Boolean

## Remove Collaborator

`DELETE /api/admin/container_registry/{container-registry-id}/collaborators/{id}`
