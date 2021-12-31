# SSH Key API

## List all SSH Keys

`GET /api/users/ssh_keys`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `ssh_keys`: Array
        * `id`: Integer
        * `label`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View SSH Keys

`GET /api/users/ssh_keys/{id}`

**OAuth AuthorizationRequired**: `profile_read`

??? abstract "schema"
    * `ssh_key`: Object
        * `id`: Integer
        * `label`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime



## Create SSH Key

`POST /api/users/ssh_keys`

**OAuth AuthorizationRequired**: `profile_update`

??? abstract "schema"
    * `ssh_key`: Object
        * `pubkey`: String


## Delete SSH Key

`DELETE /api/users/ssh_keys/{id}`

**OAuth AuthorizationRequired**: `profile_update`
