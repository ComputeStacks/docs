# Service Host Entry

Create custom host entries (`/etc/hosts`) that link to other linked images in the same project. This is intended to support backwards compatibility with docker compose.

## List all host entries

`GET /api/container_services/{container-service-id}/host_entries`

**OAuth Authorization Required**: `project_read`

??? abstract "Schema"
    - `host_entries`: Array
        - `hostname`: String
        - `ipaddr`: String
        - `keep_updated`: Boolean | If true, will look for `source_image` in project.
        - `source_image`: Object
            - `id`: Integer
            - `label`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View host entry

`GET /api/container_services/{container-service-id}/host_entries/{id}`

**OAuth Authorization Required**: `project_read`

??? abstract "Schema"
    - `host_entries`: Object
        - `hostname`: String
        - `ipaddr`: String
        - `keep_updated`: Boolean | If true, will look for `source_image` in project.
        - `source_image`: Object
            - `id`: Integer
            - `label`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Update Host Entry

`PATCH /api/container_services/{container-service-id}/host_entries/{id}`

**OAuth Authorization Required**: `project_write`

??? abstract "Schema"
    - `host_entry`: Object
        - `hostname`: String
        - `ipaddr`: String
        - `keep_updated`: Boolean | If true, will look for `source_image` in project.

---

## Create host entry

`POST /api/container_services/{container-service-id}/host_entries`

**OAuth Authorization Required**: `project_write`

??? abstract "Schema"
    - `host_entry`: Object
        - `hostname`: String
        - `ipaddr`: String

---

## Delete host entry

`DELETE /api/container_services/{container-service-id}/host_entries/{id}`

**OAuth Authorization Required**: `project_write`
