---
title: Collaborations
description: Registry Collaborator API
---
# Container Registry Collaborators

## List All Collaborators

`GET /api/container_registry/{container-registry-id}/collaborators`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `resource_owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/container_registry/{container-registry-id}/collaborators/{id}`

**OAuth AuthorizationRequired**: `projects_read`

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

`POST /api/container_registry/{container-registry-id}/collaborators`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String

## Remove Collaborator

`DELETE /api/container_registry/{container-registry-id}/collaborators/{id}`

**OAuth AuthorizationRequired**: `projects_write`
