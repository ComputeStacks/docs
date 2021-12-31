# Container Domains

## List all domains

`GET /api/domains`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `domains`: Array
        * `id`: Integer
        * `domain`: String
        * `system_domain`: Boolean
        * `header_hsts`: Boolean
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `container_service`: Integer
        * `lets_encrypt`: `String<active,pending,inactive>`
        * `links`: Hash
            * `container_service`: String (url)


## View domain

`GET /api/domains/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `domains`: Array
        * `id`: Integer
        * `domain`: String
        * `system_domain`: Boolean
        * `le_enabled`: Boolean
        * `ingress_rule_id`: Integer
        * `force_https`: Boolean
        * `header_hsts`: Boolean
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `container_service`: Integer
        * `lets_encrypt`: `String<active,pending,inactive>`
        * `links`: Hash
            * `container_service`: String (url)


## Create Domain

`POST /api/domains`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `domain`: Object
        * `domain`: String
        * `le_enabled`: Boolean
        * `heder_hsts`: Boolean
        * `container_service_id`: Integer

## Update Domain

`PATCH /api/domains/{id}`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `domain`: Object
        * `domain`: String
        * `le_enabled`: Boolean
        * `heder_hsts`: Boolean
        * `container_service_id`: Integer

## Delete Domain

`DELETE /api/domains/{id}`


## Request Domain Validation

`POST /api/domains/{id}/verify_dns`

Manually verify a domain to enable LetsEncrypt. This will happen automatically every 10-15minutes.

**OAuth AuthorizationRequired**: `projects_write`
