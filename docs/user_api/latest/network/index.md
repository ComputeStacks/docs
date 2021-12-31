# Network Ingress

## View Ingress Rule

`GET /api/networks/ingress_rules/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
* `ingress_rule`: Object
    * `id`: Integer
    * `port`: Integer
    * `port_nat`: Integer
    * `proto`: `String<http,tcp,tls,udp>`
    * `external_access`: Boolean
    * `backend_ssl`: Boolean
    * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
    * `redirect_ssl`: Boolean
    * `restrict_cf`: Boolean | If true, only allow CloudFlare
    * `tcp_lb`: Boolean
    * `created_at`: Boolean
    * `updated_at`: Boolean
    * `container_service_id`: Integer
    * `load_balancer_rule_id`: Integer
    * `internal_load_balancer_id`: Integer
    * `load_balanced_rules`: Array
    * `links`: Object
        * `domains`: String (url)

## Update Ingress Rule

`PATCH /api/networks/ingress_rules/{id}`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `ingress_rule`: Object
        * `proto`: `String<http,tcp,tls,udp>`
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
        * `backend_ssl`: String
        * `port`: Integer
        * `restrict_cf`: Boolean | If true, only allow CloudFlare
        * `tcp_lb`: Boolean

## Toggle NAT

This is a helper method to toggle external access to an ingress rule.
You may also edit the ingress rule and specify `external_access`.

`POST /api/networks/ingress_rules/{id}/toggle_nat`

**OAuth AuthorizationRequired**: `projects_write`


## Create Ingress Rule

`POST /api/networks/ingress_rules`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `ingress_rule`: Object
        * `container_service_id`: Integer | ID of Container Service, not container.
        * `proto`: `String<http,tcp,tls,udp>`
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
        * `backend_ssl`: String
        * `port`: Integer
        * `restrict_cf`: Boolean | If true, only allow CloudFlare
        * `tcp_lb`: Boolean

## Delete Ingress Rule

`DELETE /api/networks/ingress_rules/{id}`

**OAuth AuthorizationRequired**: `projects_write`

## List Domains

Find domains associated with this ingress rule

`GET /api/networks/ingress_rules/{id}/domains`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `domains`: `Array<Domain>`