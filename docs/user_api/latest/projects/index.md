# Projects API

## List Projects

`GET /api/projects`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `projects`: Array
        * `id`: Integer
        * `name`: String
        * `skip_ssh`: Boolean
        * `current_state`: `String<working,alert,ok,deleting>`
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `container_image_ids`: `Array<Integer>`
        * `links`: Hash
            * `services`: String (url)
            * `container_images`: String (url)
            * `bastions`: String (url)
        * `metadata`: Hash
            * `icons`: Array
            * `image_names`: Array


## View Project

`GET /api/projects/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `project`: Object
        * `id`: Integer
        * `name`: String
        * `skip_ssh`: Boolean
        * `current_state`: `String<working,alert,ok,deleting>`
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `container_image_ids`: `Array<Integer>`
        * `links`: Hash
            * `services`: String (url)
            * `container_images`: String (url)
            * `bastions`: String (url)
        * `metadata`: Hash
            * `icons`: Array
            * `image_names`: Array


## Update Project

`PATCH /api/projects/{id}`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `project`: Object
        * `name`: String

