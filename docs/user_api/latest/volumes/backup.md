# Backups API

## List all backups

`GET /api/volumes/{volume-id}/backups`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `name`: String
    * `usage`: Integer | Size on disk (deduplicated)
    * `size`: Integer | Expanded total size
    * `archives`: `Array<String>`

## Create a backup

`POST /volumes/{volume-id}/backups`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `name`: String | Name of backup. Must be at least 3 characters long, and should not include spaces.

## Restore a backup

`POST /volumes/{volume-id}/restore`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `name`: String | Name of backup to restore
