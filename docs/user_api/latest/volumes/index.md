# Volumes API

## List all volumes

`GET /api/volumes`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `volumes`: Array
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `container_path`: String
        * `region_id`: Integer
        * `container_service_id`: Integer
        * `to_trash`: Boolean
        * `trash_after`: DateTime
        * `size`: Decimal
        * `usage`: Decimal
        * `usage_checked`: DateTime
        * `trashed_by_id`: Integer
        * `detached_at`: DateTime
        * `subscription_id`: Integer
        * `enable_sftp`: Boolean
        * `borg_enabled`: Boolean
        * `borg_freq`: String
        * `borg_strategy`: `String<file,mysql>`
        * `borg_keep_hourly`: Integer
        * `borg_keep_daily`: Integer
        * `borg_keep_weekly`: Integer
        * `borg_keep_monthly`: Integer
        * `borg_keep_annually`: Integer
        * `borg_pre_backup`: `Array<String>`
        * `borg_post_backup`: `Array<String>`
        * `borg_pre_restore`: `Array<String>`
        * `borg_post_restore`: `Array<String>`
        * `borg_rollback`: `Array<String>`
        * `updated_at`: DateTime
        * `created_at`: DateTime

## View Volume

`GET /api/volumes/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `volume`: Object
        * `id`: Integer
        * `name`: String
        * `label`: String
        * `container_path`: String
        * `region_id`: Integer
        * `container_service_id`: Integer
        * `to_trash`: Boolean
        * `trash_after`: DateTime
        * `size`: Decimal
        * `usage`: Decimal
        * `usage_checked`: DateTime
        * `trashed_by_id`: Integer
        * `detached_at`: DateTime
        * `subscription_id`: Integer
        * `enable_sftp`: Boolean
        * `borg_enabled`: Boolean
        * `borg_freq`: String
        * `borg_strategy`: `String<file,mysql>`
        * `borg_keep_hourly`: Integer
        * `borg_keep_daily`: Integer
        * `borg_keep_weekly`: Integer
        * `borg_keep_monthly`: Integer
        * `borg_keep_annually`: Integer
        * `borg_pre_backup`: `Array<String>`
        * `borg_post_backup`: `Array<String>`
        * `borg_pre_restore`: `Array<String>`
        * `borg_post_restore`: `Array<String>`
        * `borg_rollback`: `Array<String>`
        * `updated_at`: DateTime
        * `created_at`: DateTime
