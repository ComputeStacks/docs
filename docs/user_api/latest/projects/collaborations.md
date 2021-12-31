---
title: Collaborations
description: Project Collaborator API
---
# Projects Collaborators

## List All Collaborators

`GET /api/projects/{project-id}/collaborators`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `resource_owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/projects/{project-id}/collaborators/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: Integer
        * `project`: Object
            * `id`: Integer
            * `name`: String
    * `resource_owner`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String

## Create Collaborator Request

`POST /api/projects/{project-id}/collaborators`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String

## Remove Collaborator

`DELETE /api/projects/{project-id}/collaborators/{id}`

**OAuth AuthorizationRequired**: `projects_write`
