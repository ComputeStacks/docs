# Setting Params

## List all image settings

`GET /api/container_images/{container-image-id}/setting_params`

**OAuth Authorization Required**: `images_read`, `public`

* `setting_params`: Array
    * `id`: Integer
    * `name`: String
    * `label`: String
    * `param_type`: `String<password,static>`
    * `value`: String
    * `created_at`: DateTime
    * `updated_at`: DateTime

## View a single setting

`GET /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_read`, `public`

* `setting_param`: Object
    * `id`: Integer
    * `name`: String
    * `label`: String
    * `param_type`: `String<password,static>`
    * `value`: String
    * `created_at`: DateTime
    * `updated_at`: DateTime

## Update a setting

`PATCH /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_write`

* `setting_param`: Object
    * `label`: String
    * `name`: String
    * `param_type`: `String<password,static>`
    * `value`: String

## Create a setting

`POST /api/container_images/{container-image-id}/setting_params`

**OAuth Authorization Required**: `images_write`

* `setting_param`: Object
    * `label`: String
    * `name`: String
    * `param_type`: `String<password,static>`
    * `value`: String

## Delete a setting

`DELETE /api/container_images/{container-image-id}/setting_params/{id}`

**OAuth Authorization Required**: `images_write`