# Projects: Collaborations

## List All Collaborators

`GET /api/projects/{project-id}/collaborators`

**OAuth authorization required**: `projects_read`

**Schema**

- `collaborations`: Array
    - `id`: Integer
    - `collaborator`: Object
        - `id`: Integer
        - `email`: String
        - `full_name`: String

## View Collaborator

`GET /api/projects/{project-id}/collaborators/{id}`

**OAuth authorization required**: `projects_read`

**Schema**

- `collaboration`: Object
    - `id`: Integer
    - `project`: Object
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

`POST /api/projects/{project-id}/collaborators`

**OAuth authorization required**: `projects_write`

**Schema**

- `collaborator`: Object
    - `user_email`: String

## Remove Collaborator

`DELETE /api/projects/{project-id}/collaborators/{id}`

**OAuth authorization required**: `projects_write`
