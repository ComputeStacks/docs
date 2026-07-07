# Service Resources

## List Ingress Rules

`GET /api/container_services/{container-service-id}/ingress_rules`

**OAuth authorization required**: `projects_read`

**Schema**

- `ingress_rules`: `Array<IngressRule>`

---

## List Events

`GET /api/container_services/{container-service-id}/events`

**OAuth authorization required**: `projects_read`

**Schema**

- `event_logs`: `Array<EventLog>`

---

## List Containers

`GET /api/container_services/{container-service-id}/containers`

**OAuth authorization required**: `projects_read`

**Schema**

- `containers`: `Array<Service>`

---

## List Bastion Containers

`GET /api/container_services/{container-service-id}/bastions`

**OAuth authorization required**: `projects_read`

??? abstract "Schema"
    - `bastions`: Array
        - `id`: Integer
        - `name`: String
        - `status`: String
        - `node_id`: Integer
        - `ip_addr`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `port`: Integer
        - `pw_auth`: Boolean | If true, password auth is enabled.
        - `username`: String
        - `password`: String

---

## List Load Balancers

`GET /api/container_services/{container-service-id}/load_balancers`

**OAuth authorization required**: `projects_read`

**Schema**

- `load_balancers`: `Array<LoadBalancer>`
