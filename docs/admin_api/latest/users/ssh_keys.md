---
title: SSH Keys
description: User SSH Keys
---
# SSH Key Management

## List All User Keys

`GET /api/admin/users/{user-id}/ssh_keys`

??? abstract "Schema"
    * `user_ssh_keys`: Array
        * `id`: Integer
        * `label`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View User SSH Keys

`GET /api/admin/users/{user-id}/ssh_keys/{id}`

??? abstract "Schema"
    * `user_ssh_key`: Object
        * `id`: Integer
        * `label`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Create User SSH Key

`POST /api/admin/users/{user-id}/ssh_keys`

??? abstract "Schema"
    * `user_ssh_key`: Object
        * `pubkey`: String - Public SSH Key


## Delete User SSH Key

`DELETE /api/admin/users/{user-id}/ssh_keys/{id}`
