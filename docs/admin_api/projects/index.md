---
title: Projects
description: Projects API
---
# Projects

!!! note ""
    Please see the [end-user api](https://demo.computestacks.net/documentation/api#tag/Projects){: target="_blank" } for more details.

## List All Projects

Description           | Endpoint
----------------------|-------------------------------------------
**Find All Projects** | `GET /api/admin/projects`
**Filter By User**    | `GET /api/admin/users/{user_id})/projects`


??? abstract "Schema"
    * `projects`: Array
        * `id`: Integer
        * `name`: String
        * `current_state`: String
        * `container_image_ids`: Array<Integer>
        * `user`: Object
            * `id`: Integer
            * `email`: String
            * `external_id`: String
            * `labels`: Object
        * `links`: Object
            * `services`: String
            * `container_images`: String
            * `bastions`: String
        * `metadata`: Object
            * `icons`: Array
            * `image_names`: Array
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Project

`GET /api/admin/projects/{id}`

??? abstract "Schema"
    * `project`: Object
        * `id`: Integer
        * `name`: String
        * `current_state`: String
        * `container_image_ids`: Array<Integer>
        * `user`: Object
            * `id`: Integer
            * `email`: String
            * `external_id`: String
            * `labels`: Object
        * `links`: Object
            * `services`: String
            * `container_images`: String
            * `bastions`: String
        * `metadata`: Object
            * `icons`: Array
            * `image_names`: Array
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Update Project

`PATCH /api/admin/projects/{id}`

Params:
* `project`: Object
  * `name`: String - project name
  * `user_id`: Integer -- Only supply this if you want to change the project owner!

