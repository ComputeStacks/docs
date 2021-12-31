# SSL Certificates

!!! alert ""
    Custom SSL Certificates only. Will not return LetsEncrypt certificates.

## List SSL Certificates

`GET /api/container_services/{container-service-id}/ssl`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `certificates`: Array
        * `id`: Integer
        * `cert_serial`: String
        * `issuer`: String
        * `subject`: String
        * `not_before`: DateTime
        * `not_after`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View SSL Certificate

`GET /api/container_services/{container-service-id}/ssl/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `certificates`: Object
        * `id`: Integer
        * `cert_serial`: String
        * `issuer`: String
        * `subject`: String
        * `not_before`: DateTime
        * `not_after`: DateTime
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Create SSL Certificate

`POST /api/container_services/{container-service-id}/ssl`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `certificate`: Object
        * `ca`: String
        * `crt`: String
        * `pkey`: String

## Delete certificate

`DELETE /api/container_services/{container-service-id}/ssl/{id}`

**OAuth AuthorizationRequired**: `projects_write`