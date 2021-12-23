---
title: Container Registry
description: Container Registry API
---
# Container Registry

## List All Container Registries

`GET /api/admin/container_registry`

??? abstract "Schema"
    * `container_registries`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `status`: String [new,deploying,deployed,error,working]
        * `endpoint`: String
        * `username`: String
        * `password`: String
        * `images`: Array of Strings
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Container Registry

`GET /api/admin/container_registry/{id}`

??? abstract "Schema"
    * `container_registry`: Object
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `status`: String [new,deploying,deployed,error,working]
        * `endpoint`: String
        * `username`: String
        * `password`: String
        * `images`: Array of Strings
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Edit Container Registry

`PATCH /api/admin/container_registry/{id}`

??? abstract "Schema"
    * `container_registry`: Object
        * `label`: String
        * `user_id`: Integer - Only supply if you wish to change owner.


## Create Container Registry

`POST /api/admin/container_registry`

??? abstract "Schema"
    * `container_registry`: Object
        * `label`: String
        * `user_id`: Integer


## Delete Container Registry

`DESTROY /api/admin/container_registry/{id}`