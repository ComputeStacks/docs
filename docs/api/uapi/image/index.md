# Image

[Image Collaborations](image-collaborations.md)

[Image Environmental Params](image-environmental-params.md)

[Image Host Entry](image-host-entry.md)

[Image Ingress Parameters](image-ingress-parameters.md)

[Image Collections](image-collections.md)

[Image Providers](image-providers.md)

[Image Relationships](image-relationships.md)

[Image Setting Params](image-setting-params.md)

[Image Variants](image-variants.md)

[Image Volumes](image-volumes.md)

---

## List all volumes

`GET /api/container_images/{container-image-id}/volume_params`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `volume_params`: Array
        - `id`: Integer
        - `label`: String
        - `mount_path`: String
        - `enable_sftp`: Boolean
        - `borg_enabled`: Boolean
        - `borg_freq`: String
        - `borg_strategy`: `String<file,mysql>`
        - `borg_keep_hourly`: Integer
        - `borg_keep_daily`: Integer
        - `borg_keep_weekly`: Integer
        - `borg_keep_monthly`: Integer
        - `borg_keep_annually`: Integer
        - `borg_pre_backup`: `Array<String>`
        - `borg_post_backup`: `Array<String>`
        - `borg_pre_restore`: `Array<String>`
        - `borg_post_restore`: `Array<String>`
        - `borg_rollback`: `Array<String>`
        - `updated_at`: DateTime
        - `created_at`: DateTime

## View a single volume

`GET /api/container_images/{container-image-id}/volume_params/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "Schema"
    - `volume_params`: Object
        - `id`: Integer
        - `label`: String
        - `mount_path`: String
        - `enable_sftp`: Boolean
        - `borg_enabled`: Boolean
        - `borg_freq`: String
        - `borg_strategy`: `String<file,mysql>`
        - `borg_keep_hourly`: Integer
        - `borg_keep_daily`: Integer
        - `borg_keep_weekly`: Integer
        - `borg_keep_monthly`: Integer
        - `borg_keep_annually`: Integer
        - `borg_pre_backup`: `Array<String>`
        - `borg_post_backup`: `Array<String>`
        - `borg_pre_restore`: `Array<String>`
        - `borg_post_restore`: `Array<String>`
        - `borg_rollback`: `Array<String>`
        - `updated_at`: DateTime
        - `created_at`: DateTime

## Update a volume

`PATCH /api/container_images/{container-image-id}/volume_params/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `volume_params`: Object
        - `label`: String
        - `mount_path`: String
        - `enable_sftp`: Boolean
        - `borg_enabled`: Boolean
        - `borg_freq`: String
        - `borg_strategy`: `String<file,mysql>`
        - `borg_keep_hourly`: Integer
        - `borg_keep_daily`: Integer
        - `borg_keep_weekly`: Integer
        - `borg_keep_monthly`: Integer
        - `borg_keep_annually`: Integer
        - `borg_pre_backup`: `Array<String>`
        - `borg_post_backup`: `Array<String>`
        - `borg_pre_restore`: `Array<String>`
        - `borg_post_restore`: `Array<String>`
        - `borg_rollback`: `Array<String>`

## Create a volume

`POST /api/container_images/{container-image-id}/volume_params`

**OAuth Authorization Required**: `images_write`

??? abstract "Schema"
    - `volume_params`: Object
        - `label`: String
        - `mount_path`: String
        - `enable_sftp`: Boolean
        - `borg_enabled`: Boolean
        - `borg_freq`: String
        - `borg_strategy`: `String<file,mysql>`
        - `borg_keep_hourly`: Integer
        - `borg_keep_daily`: Integer
        - `borg_keep_weekly`: Integer
        - `borg_keep_monthly`: Integer
        - `borg_keep_annually`: Integer
        - `borg_pre_backup`: `Array<String>`
        - `borg_post_backup`: `Array<String>`
        - `borg_pre_restore`: `Array<String>`
        - `borg_post_restore`: `Array<String>`
        - `borg_rollback`: `Array<String>`

## Delete a volume

`DELETE /api/container_images/{container-image-id}/volume_params/{id}`

**OAuth Authorization Required**: `images_write`
