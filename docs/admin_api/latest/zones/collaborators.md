---
title: Collaborators
description: DNS Zone Collaborator API
---
# DNS Zone Collaborator Collaborators

## List All Collaborators

`GET /api/admin/zones/{zone-id}/collaborators`

??? abstract "Schema"
    * `collaborations`: Array
        * `id`: Integer
        * `resource_owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String

## View Collaborator

`GET /api/admin/zones/{zone-id}/collaborators/{id}`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: Integer
        * `zone`: Object
            * `id`: Integer
            * `name`: String
    * `resource_owner`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String

## Create Collaborator Request

`POST /api/admin/zones/{zone-id}/collaborators`

??? abstract "Schema"
    * `collaborator`: Object
        * `user_email`: String
        * `skip_confirmation`: Boolean

## Remove Collaborator

`DELETE /api/admin/zones/{zone-id}/collaborators/{id}`