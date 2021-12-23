---
title: Images
description: Container Images
---
# Images

!!! note ""
    Please see the [end-user api](https://demo.computestacks.net/documentation/api#tag/Container-Images){: target="_blank" } for more details.

## List all images

`GET /api/admin/container_images`

null user == public (system) image.

## View an image

`GET /api/admin/container_images/{id}`

null user == public (system) image.

---

## Manually Pull Container Image

!!! tip ""
    This is only necessary for images that do not belong to a user _(public images)_.
        
    User's custom images that they have configured in ComputeStacks are **automatically pulled on _each_ rebuild**.

`POST /api/admin/container_images/{id}/pull`
