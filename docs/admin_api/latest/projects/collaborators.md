---
title: Collaborations
description: Project Collaborator API
---
# Projects Collaborators

## List All Collaborators

`GET /api/admin/projects/{project-id}/collaborators`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `collaborator`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/admin/projects/{project-id}/collaborators/{id}`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: Integer
        * `project`: Object
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

`POST /api/admin/projects/{project-id}/collaborators`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String
        * `skip_confirmation`: Boolean

## Remove Collaborator

`DELETE /api/admin/projects/{project-id}/collaborators/{id}`
