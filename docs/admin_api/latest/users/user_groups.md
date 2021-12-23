---
title: User Groups
description: User Groups API
---
# User Groups

## List All User Groups

`GET /api/admin/user_groups`

??? abstract "Schema"
    * `user_groups`: Array
        * `id`: Integer
        * `name`: String
        * `is_default`: Boolean
        * `billing_plan_id`: Integer
        * `active`: Boolean
        * `q_containers`: Integer
        * `q_dns_zones`: Integer
        * `q_cr`: Integer
        * `allow_local_volume`: Boolean - When using NFS volume storage, enable this to allow users to choose.
        * `bill_offline`: Boolean - Continue billing containers when they're stopped. Volumes and backups are always billed. (default: true)
        * `bill_suspended`: Boolean - Continue billing suspended users. (default: true)
        * `remove_stopped`: Boolean - Remove stopped containers from the node. Persistent volumes will remain. When the user starts the container, it will be repovisioned automatically. (default: false)
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View User Group

`GET /api/admin/user_groups/{id}`

??? abstract "Schema"
    * `user_group`: Object
        * `id`: Integer
        * `name`: String
        * `is_default`: Boolean
        * `billing_plan_id`: Integer
        * `active`: Boolean
        * `q_containers`: Integer
        * `q_dns_zones`: Integer
        * `q_cr`: Integer
        * `allow_local_volume`: Boolean - When using NFS volume storage, enable this to allow users to choose.
        * `bill_offline`: Boolean - Continue billing containers when they're stopped. Volumes and backups are always billed. (default: true)
        * `bill_suspended`: Boolean - Continue billing suspended users. (default: true)
        * `remove_stopped`: Boolean - Remove stopped containers from the node. Persistent volumes will remain. When the user starts the container, it will be repovisioned automatically. (default: false)
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Edit User Group

`PATCH /api/admin/user_groups/{id}`

??? abstract "Schema"
    * `user_group`: Object
        * `name`: String
        * `is_default`: Boolean
        * `billing_plan_id`: Integer
        * `active`: Boolean
        * `q_containers`: Integer
        * `q_dns_zones`: Integer
        * `q_cr`: Integer
        * `allow_local_volume`: Boolean - When using NFS volume storage, enable this to allow users to choose.
        * `bill_offline`: Boolean - Continue billing containers when they're stopped. Volumes and backups are always billed. (default: true)
        * `bill_suspended`: Boolean - Continue billing suspended users. (default: true)
        * `remove_stopped`: Boolean - Remove stopped containers from the node. Persistent volumes will remain. When the user starts the container, it will be repovisioned automatically. (default: false)


## Create User Group

`POST /api/admin/user_groups`

??? abstract "Schema"
    * `user_group`: Object
        * `name`: String
        * `is_default`: Boolean
        * `billing_plan_id`: Integer
        * `active`: Boolean
        * `q_containers`: Integer
        * `q_dns_zones`: Integer
        * `q_cr`: Integer
        * `allow_local_volume`: Boolean - When using NFS volume storage, enable this to allow users to choose.
        * `bill_offline`: Boolean - Continue billing containers when they're stopped. Volumes and backups are always billed. (default: true)
        * `bill_suspended`: Boolean - Continue billing suspended users. (default: true)
        * `remove_stopped`: Boolean - Remove stopped containers from the node. Persistent volumes will remain. When the user starts the container, it will be repovisioned automatically. (default: false)

## Delete User Group

`DELETE /api/admin/user_groups/{id}`

You must first remove any users from this group before deleting it
