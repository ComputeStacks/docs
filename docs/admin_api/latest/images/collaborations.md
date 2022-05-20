---
title: Collaborations
description: Image Collaborator API
---
# Image Collaborators

## List All Collaborators

`GET /api/admin/container_images/{container-image-id}/collaborators`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `collaborator`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/admin/container_images/{container-image-id}/collaborators/{id}`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: String
        * `image`: Object
            * `id`: Integer
            * `name`: String
    * `collaborator`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String
    * `resource_owner`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String


## Create Collaborator Request

`POST /api/admin/container_images/{container-image-id}/collaborators`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String
        * `skip_confirmation`: Boolean - Add and activate without email notification.


