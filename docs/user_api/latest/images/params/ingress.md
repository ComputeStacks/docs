# Ingress Params

## List all ingress params for a given image

`GET /api/container_images/{container-image-id}/ingress_params`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `ingress_params`: Array
        * `port`: Integer
        * `proto`: `String<tcp,udp,tls>`
        * `backend_ssl`: Boolean
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
        * `tcp_lb`: Boolean
        * `updated_at`: DateTime
        * `created_at`: DateTime
        * `load_balancer_id`: Integer
        * `internal_load_balancer_id`: Integer

## View a single ingress param

`GET /api/container_images/{container-image-id}/ingress_params/{id}`

**OAuth Authorization Required**: `images_read`, `public`

??? abstract "schema"
    * `ingress_param`: Object
        * `port`: Integer
        * `proto`: `String<tcp,udp,tls>`
        * `backend_ssl`: Boolean
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>`
        * `tcp_lb`: Boolean
        * `updated_at`: DateTime
        * `created_at`: DateTime
        * `load_balancer_id`: Integer
        * `internal_load_balancer_id`: Integer

## Update an ingress param

`PATCH /api/container_images/{container-image-id}/ingress_params/{id}`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `ingress_param`: Object
        * `port`: Integer
        * `proto`: `String<tcp,udp,tls>`
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>` | Ensure your backend supports the `PROXY` protocol before enabling this.
        * `backend_ssl`: Boolean

## Create an ingress param

`POST /api/container_images/{container-image-id}/ingress_params`

**OAuth Authorization Required**: `images_write`

??? abstract "schema"
    * `ingress_param`: Object
        * `port`: Integer
        * `proto`: `String<tcp,udp,tls>`
        * `external_access`: Boolean
        * `tcp_proxy_opt`: `String<none,send-proxy,send-proxy-v2,send-proxy-v2-ssl,send-proxy-v2-ssl-cn>` | Ensure your backend supports the `PROXY` protocol before enabling this.
        * `backend_ssl`: Boolean

## Delete an ingress param

`DELETE /api/container_images/{container-image-id}/ingress_params/{id}`

**OAuth Authorization Required**: `images_write`