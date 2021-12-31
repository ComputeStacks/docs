# Service Resources

## List Ingress Rules

`GET /api/container_services/{container-service-id}/ingress_rules`

**OAuth AuthorizationRequired**: `projects_read`

* `ingress_rules`: `Array<IngressRule>`


## List Events

`GET /api/container_services/{container-service-id}/events`

**OAuth AuthorizationRequired**: `projects_read`

* `event_logs`: `Array<EventLog>`

## List Containers

`GET /api/container_services/{container-service-id}/containers`

**OAuth AuthorizationRequired**: `projects_read`

* `containers`: `Array<Service>
`
## List Bastion Containers

`GET /api/container_services/{container-service-id}/bastions`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `bastions`: Array
        * `id`: Integer
        * `name`: String
        * `status`: String
        * `node_id`: Integer
        * `ip_addr`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `port`: Integer
        * `pw_auth`: Boolean | If true, password auth is enabled.
        * `username`: String
        * `password`: String

## List Load Balancers

`GET /api/container_services/{container-service-id}/load_balancers`

**OAuth AuthorizationRequired**: `projects_read`

* `load_balancers`: `Array<LoadBalancer>`