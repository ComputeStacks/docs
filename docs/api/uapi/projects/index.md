# Projects

[Projects: Collaborations](projects-collaborations.md)

[Projects: Resources](projects-resources.md)

---

## List Projects

`GET /api/projects`

**OAuth authorization required**: `projects_read`

??? abstract "Schema"
    - `projects`: Array
        - `id`: Integer
        - `name`: String
        - `skip_ssh`: Boolean
        - `current_state`: `String<working,alert,ok,deleting>`
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `container_image_ids`: `Array<Integer>`
        - `links`: Hash
            - `services`: String (url)
            - `container_images`: String (url)
            - `bastions`: String (url)
        - `metadata`: Hash
            - `icons`: Array
            - `image_names`: Array

---

## View Project

`GET /api/projects/{id}`

**OAuth authorization required**: `projects_read`

??? abstract "Schema"
    - `project`: Object
        - `id`: Integer
        - `name`: String
        - `skip_ssh`: Boolean
        - `current_state`: `String<working,alert,ok,deleting>`
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `container_image_ids`: `Array<Integer>`
        - `links`: Hash
            - `services`: String (url)
            - `container_images`: String (url)
            - `bastions`: String (url)
        - `metadata`: Hash
            - `icons`: Array
            - `image_names`: Array

---

## Update Project

`PATCH /api/projects/{id}`

**OAuth authorization required**: `projects_write`

??? abstract "Schema"
    - `project`: Object
        - `name`: String

---

## Delete Project

`DELETE /api/projects/{id}`

**OAuth authorization required**: `projects_write`
