---
title: DNS Zones
description: DNS Zones API
---
# DNS Zones

## List all zones

`GET /api/admin/zones`

You may optionally include `?user_id=` to filter zones by user.

??? abstract "Schema"
    * `zones`: Array
      * `id`: Integer
      * `name`: String
      * `user`: Object
          * `id`: Integer
          * `email`: String
          * `external_id`: String
          * `labels`: Object
      * `created_at`: DateTime
      * `updated_at`: DateTime
