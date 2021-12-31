# Container Images

## List All Images

`GET /api/container_images`

**OAuth Authorization Required**: `images_read`, `public`

**Optional Filter Parameters**

Name                | URL Param
--------------------|-------------------------
Owned by your user? | `?filter=owned`
Is Load Balancer?   | `?filter=isLoadBalancer`

??? abstract "schema"
    * `container_images`: Array
        * `id`: Integer
        * `active`: Boolean
        * `is_load_balancer`: Boolean
        * `can_scale`: Boolean
        * `command`: String | Command execued by container on start
        * `container_image_provider_id`: Integer
        * `description`: String
        * `domains_block_id`: Integer
        * `general_block_id`: Integer
        * `icon_url`: String
        * `image_url`: String
        * `is_free`: Boolean
        * `label`: String
        * `min_cpu`: Decimal | Supports fractional cores
        * `labels`: Array
            * `key`: String
            * `value`: String
        * `min_memory`: Integer
        * `name`: String
        * `registry_auth`: Boolean
        * `registry_custom`: String
        * `registry_image_path`: String
        * `registry_image_tag`: String
        * `remote_block_id`: Integer
        * `role`: String | Used in generating variables
        * `role_class`: `String<web, database, cache, dev, misc>`
        * `ssh_block_id`: Integer
        * `user_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `required_containers`: `Array<Integer>`
        * `required_by`: `Array<Integer`
        * `container_image_env_params`: Array
            * `id`: Integer
            * `name`: String
            * `label`: String
            * `param_type`: `String<static,variable>`
            * `env_value`: String
            * `static_value`: String
            * `updated_at`: DateTime
            * `created_at`: DateTime
        * `container_image_settings_params`: Array
            * `id`: Integer
            * `name`: String
            * `label`: String
            * `param_type`: `String<password,static>` | Password will auto-gen value
            * `value`: String
            * `updated_at`: DateTime
            * `created_at`: DateTime

## View Container Image

`GET /api/container_images/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `container_images`: Array
        * `id`: Integer
        * `active`: Boolean
        * `is_load_balancer`: Boolean
        * `can_scale`: Boolean
        * `command`: String | Command execued by container on start
        * `container_image_provider_id`: Integer
        * `description`: String
        * `domains_block_id`: Integer
        * `general_block_id`: Integer
        * `icon_url`: String
        * `image_url`: String
        * `is_free`: Boolean
        * `label`: String
        * `min_cpu`: Decimal | Supports fractional cores
        * `labels`: Array
            * `key`: String
            * `value`: String
        * `min_memory`: Integer
        * `name`: String
        * `registry_auth`: Boolean
        * `registry_custom`: String
        * `registry_image_path`: String
        * `registry_image_tag`: String
        * `remote_block_id`: Integer
        * `role`: String | Used in generating variables
        * `role_class`: `String<web, database, cache, dev, misc>`
        * `ssh_block_id`: Integer
        * `user_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `required_containers`: `Array<Integer>`
        * `required_by`: `Array<Integer`
        * `container_image_env_params`: Array
            * `id`: Integer
            * `name`: String
            * `label`: String
            * `param_type`: `String<static,variable>`
            * `env_value`: String
            * `static_value`: String
            * `updated_at`: DateTime
            * `created_at`: DateTime
        * `container_image_settings_params`: Array
            * `id`: Integer
            * `name`: String
            * `label`: String
            * `param_type`: `String<password,static>` | Password will auto-gen value
            * `value`: String
            * `updated_at`: DateTime
            * `created_at`: DateTime

## Update an image

`PATCH /api/container_images/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `container_image`: Object
        * `label`: String
        * `description`: String
        * `active`: Boolean | Available for order?
        * `role`: String
        * `role_class`: String
        * `can_scale`: Boolean
        * `min_cpu`: Decimal
        * `min_memory`: Integer
        * `container_image_provider_id`: Integer
        * `registry_auth`: Boolean
        * `registry_custom`: String
        * `registry_image_path`: String
        * `registry_image_tag`: String
        * `registry_username`: String
        * `registry_password`: String
        * `is_free`: Boolean (Admin)
        * `override_autoremove`: Boolean (Admin)

## Create an image

`POST /api/container_images`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `container_image`: Object
        * `label`: String
        * `description`: String
        * `active`: Boolean | Available for order?
        * `role`: String
        * `role_class`: String
        * `can_scale`: Boolean
        * `min_cpu`: Decimal
        * `min_memory`: Integer
        * `container_image_provider_id`: Integer
        * `registry_auth`: Boolean
        * `registry_custom`: String
        * `registry_image_path`: String
        * `registry_image_tag`: String
        * `registry_username`: String
        * `registry_password`: String
        * `is_free`: Boolean (Admin)
        * `override_autoremove`: Boolean (Admin)
        * `env_params_attributes`: Array
        * `label`: String
        * `name`: String
        * `param_type`: `String<static,variable>`
        * `env_value`: String | When `param_type` is `variable`
        * `static_value`: String | When `param_type` is `static`
        * `ingress_params_attributes`: Array
            * `port`: Integer
            * `proto`: `String<tcp,udp,tls>`
            * `backend_ssl`: Boolean
            * `external_access`: Boolean
            * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
        * `setting_params_attributes`: Array
            * `name`: String
            * `label`: String
            * `param_type`: `String<static,variable>`
            * `value`: String
        * `volume_attributes`: Array
            * `label`: String
            * `mount_path`: String
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


## Destroy an image

**OAuth Authorization Required**: `images_write`

`DELETE /api/container_images/{id}`
