# User: SSH Key

## List all SSH Keys

`GET /api/users/ssh_keys`

**OAuth authorization required**: `profile_read`

**Schema**

- `ssh_keys`: Array
    - `id`: Integer
    - `label`: String
    - `created_at`: DateTime
    - `updated_at`: DateTime

## View SSH Keys

`GET /api/users/ssh_keys/{id}`

**OAuth authorization required**: `profile_read`

**Schema**

- `ssh_key`: Object
    - `id`: Integer
    - `label`: String
    - `created_at`: DateTime
    - `updated_at`: DateTime

## Create SSH Key

`POST /api/users/ssh_keys`

**OAuth authorization required**: `profile_update`

**Schema**

- `ssh_key`: Object
    - `pubkey`: String

## Delete SSH Key

`DELETE /api/users/ssh_keys/{id}`

**OAuth authorization required**: `profile_update`
