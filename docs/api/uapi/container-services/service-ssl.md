# Service SSL

!!! warning
    Custom SSL Certificates only. Will not return LetsEncrypt certificates.

## List SSL Certificates

`GET /api/container_services/{container-service-id}/ssl`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `certificates`: Array
        - `id`: Integer
        - `cert_serial`: String
        - `issuer`: String
        - `subject`: String
        - `not_before`: DateTime
        - `not_after`: DateTime
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## View SSL Certificate

`GET /api/container_services/{container-service-id}/ssl/{id}`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `certificates`: Object
        - `id`: Integer
        - `cert_serial`: String
        - `issuer`: String
        - `subject`: String
        - `not_before`: DateTime
        - `not_after`: DateTime
        - `created_at`: DateTime
        - `updated_at`: DateTime

---

## Create SSL Certificate

`POST /api/container_services/{container-service-id}/ssl`

**OAuth authorization required**: `project_write`

??? abstract "Schema"
    - `certificate`: Object
        - `ca`: String
        - `crt`: String
        - `pkey`: String

---

## Delete certificate

`DELETE /api/container_services/{container-service-id}/ssl/{id}`

**OAuth authorization required**: `project_write`
