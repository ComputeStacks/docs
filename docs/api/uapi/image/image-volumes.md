# Image Volumes

[IMAGES](index.md)

- [Collaborations](image-collaborations.md)
- [Environmental Param](image-environmental-params.md)
- [Host Entry](image-host-entry.md)
- [Ingress Params](image-ingress-parameters.md)
- [Image Providers](image-ingress-parameters.md)
- [Relationships](image-relationships.md)
- [Setting Params](image-setting-params.md)
- [Image Variants](image-variants.md)
- [Volumes](image-volumes.md)

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
        - `mount_ro`: Bool
        - `source_volume_id`: Integer | VolumeParam, not Volume.
        - `updated_at`: DateTime
        - `created_at`: DateTime

---

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
        - `mount_ro`: Bool
        - `source_volume_id`: Integer | VolumeParam, not Volume.
        - `updated_at`: DateTime
        - `created_at`: DateTime

---

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
        - `mount_ro`: Bool
        - `source_volume_id`: Integer | VolumeParam, not Volume.

---

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
        - `mount_ro`: Bool
        - `source_volume_id`: Integer | VolumeParam, not Volume.

---

## Delete a volume

`DELETE /api/container_images/{container-image-id}/volume_params/{id}`

**OAuth Authorization Required**: `images_write`
