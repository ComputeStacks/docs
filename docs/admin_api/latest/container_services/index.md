---
title: Container Services
description: Container Services API
---
# Container Services

## List All Container Services

`GET /api/admin/container_services`

!!! tip ""
    add `?all=true` to include same data as in end-user api, plus the `project` and `user` objects from the schema below.
    
??? abstract "Schema"
    * `container_services`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `project`: Object
            * `id`: Integer
            * `name`: String
        * `user`
            * `id`: Integer
            * `full_name`: String
            * `email`: String
            * `external_id`: String
            * `labels`: Object


## Get Container Service

`GET /api/admin/container_services/{id}`

Will return the same schema as the end-user api.
