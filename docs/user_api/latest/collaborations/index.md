---
title: Collaborations
description: Collaboration API
---
# Collaboration

## List All Collaborations

`GET /api/collaborations`

??? abstract "Schema"
    * `projects`: Array
        * `id`: String
        * `owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String
        * `project`: Object
            * `id`: Integer
            * `name`: String
    * `domains`: Array
        * `id`: String
        * `owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String
        * `domain`: Object
            * `id`: Integer
            * `name`: String
    * `images`: Array
        * `id`: String
        * `owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String
        * `image`: Object
            * `id`: Integer
            * `name`: String
    * `registries`: Array
        * `id`: String
        * `owner`: Object
            * `id`: Integer
            * `email`: String
            * `full_name`: String
        * `registry`: Object
            * `id`: Integer
            * `name`: String

## View Collaboration

`GET /api/collaborations/{id}`

??? abstract "Schema"
    * `collaboration`: Object
        * `id`: String
        * `{resource}`: Object - Where `resource` is one of: project, image, zone, registry
            * `id`: Integer
            * `name`: String
    * `resource_owner`: Object
        * `id`: Integer
        * `email`: String
        * `full_name`: String

## Enable Collaboration

`PATCH /api/collaborations/{id}`

When initially invited, the active will be disabled.

??? abstract "Schema"
    * `collaboration`: Object
        * `active`: Boolean
