# Projects

[Project: Collaborators](project-collaborators.md)

---

## List All Projects

| **Description** | **Endpoint** |
| --- | --- |
| Find All Projects | `GET /api/admin/projects` |
| Filter By User | `GET /api/admin/users/{user_id}/projects` |

??? abstract "Schema"
    - `projects`: Array
        - `id`: Integer
        - `name`: String
        - `current_state`: String
        - `container_image_ids`: `Array<Integer>`
        - `user`: Object
            - `id`: Integer
            - `email`: String
            - `external_id`: String
            - `labels`: Object
        - `links`: Object
            - `services`: String
            - `container_images`: String
            - `bastions`: String
        - `metadata`: Object
            - `icons`: Array
            - `image_names`: Array
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View Project

`GET /api/admin/projects/{id}`

??? abstract "Schema"
    - `project`: Object
        - `id`: Integer
        - `name`: String
        - `current_state`: String
        - `container_image_ids`: `Array<Integer>`
        - `user`: Object
            - `id`: Integer
            - `email`: String
            - `external_id`: String
            - `labels`: Object
        - `links`: Object
            - `services`: String
            - `container_images`: String
            - `bastions`: String
        - `metadata`: Object
            - `icons`: Array
            - `image_names`: Array
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Update Project

`PATCH /api/admin/projects/{id}`

??? abstract "Schema"
    - `project`: Object
        - `name`: String - project name
        - `user_id`: Integer -- Only supply this if you want to change the project owner!
