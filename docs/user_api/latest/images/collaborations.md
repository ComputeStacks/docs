---
title: Collaborations
description: Container Image Collaborator API
---
# Container Image Collaborators

## List All Collaborators

`GET /api/container_images/{container-image-id}/collaborators`

**OAuth Authorization Required**: `images_read`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `collaborator`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/container_images/{container-image-id}/collaborators/{id}`

**OAuth Authorization Required**: `images_read`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: Integer
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

`POST /api/container_images/{container-image-id}/collaborators`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String

## Remove Collaborator

`DELETE /api/container_images/{container-image-id}/collaborators/{id}`

**OAuth Authorization Required**: `images_write`

