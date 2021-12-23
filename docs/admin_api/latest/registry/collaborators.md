---
title: Collaborations
description: Registry Collaborator API
---
# Container Registry Collaborators

## List All Collaborators

`GET /api/admin/container_registry/{container-registry-id}/collaborators`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `resource_owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/admin/container_registry/{container-registry-id}/collaborators/{id}`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: Integer
        * `registry`: Object
            * `id`: Integer
            * `name`: String
    * `resource_owner`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String

## Create Collaborator Request

`POST /api/admin/container_registry/{container-registry-id}/collaborators`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String
        * `skip_confirmation`: Boolean

## Remove Collaborator

`DELETE /api/admin/container_registry/{container-registry-id}/collaborators/{id}`
