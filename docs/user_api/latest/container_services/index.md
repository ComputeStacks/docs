# Container Service API

## List all container services

`GET /api/container_services`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `container_services`: Array
        * `id`: Integer
        * `name`: String
        * `default_domain`: String
        * `public_ip`: String
        * `command`: String
        * `is_load_balancer`: Boolean
        * `has_domain_management`: Boolean
        * `container_image_id`: Integer
        * `current_state`: String
        * `auto_scale`: Boolean
        * `auto_scale_horizontal`: Boolean
        * `auto_scale_max`: Boolean
        * `labels`: Object
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `project`: Object
            * `id`: Integer
            * `name`: String
        * `package`: Object
            * `label`: String
            * `cpu`: Decimal
            * `memory`: Integer
            * `storage`: Integer
            * `bandwidth`: Integer
            * `local_disk`: Integer
            * `backup`: Integer
            * `memory_swap`: Integer
            * `memory_swappiness`: Integer
        * `has_sftp`: Boolean
        * `ingress_rules`: `Array<Integer>`
        * `product_id`: Integer
        * `bastions`: `Array<Integer>`
        * `domains`: `Array<Integer>`
        * `deployed_containers`: Integer
        * `help`: Object
            * `general`: String
            * `ssh`: String
            * `remote`: String
            * `domain`: String
        * `links`: Object
            * `project`: String (url)
            * `bastions`: String (url)
            * `containers`: String (url)
            * `events`: String (url)
            * `ingress_rules`: String (url)
            * `metadata`: String (url)
            * `logs`: String (url)
            * `products`: String (url)


## View Container Service

`GET /api/container_services/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `container_service`: Object
        * `id`: Integer
        * `name`: String
        * `default_domain`: String
        * `public_ip`: String
        * `command`: String
        * `is_load_balancer`: Boolean
        * `has_domain_management`: Boolean
        * `container_image_id`: Integer
        * `current_state`: String
        * `auto_scale`: Boolean
        * `auto_scale_horizontal`: Boolean
        * `auto_scale_max`: Boolean
        * `labels`: Object
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `project`: Object
            * `id`: Integer
            * `name`: String
        * `package`: Object
            * `label`: String
            * `cpu`: Decimal
            * `memory`: Integer
            * `storage`: Integer
            * `bandwidth`: Integer
            * `local_disk`: Integer
            * `backup`: Integer
            * `memory_swap`: Integer
            * `memory_swappiness`: Integer
        * `has_sftp`: Boolean
        * `ingress_rules`: `Array<Integer>`
        * `product_id`: Integer
        * `bastions`: `Array<Integer>`
        * `domains`: `Array<Integer>`
        * `deployed_containers`: Integer
        * `help`: Object
            * `general`: String
            * `ssh`: String
            * `remote`: String
            * `domain`: String
        * `links`: Object
            * `project`: String (url)
            * `bastions`: String (url)
            * `containers`: String (url)
            * `events`: String (url)
            * `ingress_rules`: String (url)
            * `metadata`: String (url)
            * `logs`: String (url)
            * `products`: String (url)

## Update a container service

`PATCH /api/container_services/{id}`

**OAuth AuthorizationRequired**: `projects_write`

??? abstract "schema"
    * `container_service`: Object
        * `name`: String
        * `scale`: Integer
        * `package_id`: Integer


## Delete a container service

`DELETE /api/container_services/{id}`

  **OAuth AuthorizationRequired**: `projects_write`

## Resize Service

Initiate a resize event for a ContainerService

`POST /api/container_services/{container-service-id}/resize`

**OAuth AuthorizationRequired**: `projects_write`

* `product_id`: Integer | New plan

??? example "Example"
    ```json
    {
        "container_service": {
            "product_id": 2
        }
    }
    ```

## Scale Service

Initiate a scale event for a ContainerService

`POST /api/container_services/{container-service-id}/scale`

**OAuth AuthorizationRequired**: `projects_write`

* `qty`: Integer | The total number of containers this service should have #

??? example "Example"
    ```json
    {
        "container_service": {
            "qty": 2
        }
    }
    ```

## Power Management

Perform a power action on all containers belonging to a service

`POST /api/container_services/{container-service-id}/power/{action}`

**OAuth AuthorizationRequired**: `projects_write`

* `action`: `String<start,stop,restart,rebuild>`

## Logs

View Recent Logs

`GET /api/container_services/{id}/logs`

**OAuth AuthorizationRequired**: `projects_read`

* `limit`: Integer | How many lines to include?
* `period_start`: Integer | Log date range (start). As an integer, time since epoch. Default: 1 day ago
* `period_end`: Integer | Log date range (end). As an integer, time since epoch. Default: Now

Returns an Array of Arrays containing: Timestamp, container name, log entry

??? example "Example"
    ```json
    [
        [
            1612904254.9995728,
            "mystifying-poincare61-104",
            "t=2021-02-09T20:57:34+0000 lvl=info msg=\"HTTP Server Listen\" logger=http.server address=[::]:3000 protocol=http subUrl= socket="
        ],
        [
            1612904254.991145,
            "mystifying-poincare61-104",
            "t=2021-02-09T20:57:34+0000 lvl=info msg=\"Registering plugin\" logger=plugins id=input"
        ],
        [
            1612904254.8895183,
            "mystifying-poincare61-104",
            "t=2021-02-09T20:57:34+0000 lvl=info msg=\"Starting plugin search\" logger=plugins"
        ]
    ]
    ```