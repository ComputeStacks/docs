# Containers API

## View Container

`GET /api/containers/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `containers`: Array
        * `id`: Integer
        * `name`: String
        * `req_state`: `String<running,stopped>`
        * `stats`: Object
            * `cpu`: Decimal
            * `mem`: Decimal
        * `current_state`: `String<migrating,starting,stopping,working,alert,resource_usage,online,offline>`
        * `local_ip`: String
        * `public_ip`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `ingress_rules`: Array
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

## Power Control

`PUT /api/containers/{container-id}/power/{action}`

**OAuth AuthorizationRequired**: `projects_write`

`action`: `String<start,stop,restart,rebuild>`

## Container Logs

`GET /api/containers/{id}/logs`

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

## Container Processes

View processes inside of a container

`GET /api/containers/{container-id}/container_processes`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    Returns an Array of Objects containing:

    * `UID`: String
    * `PID`: Integer
    * `PPID`: Integer
    * `C`: Integer
    * `STIME`: String
    * `TTY`: String
    * `TIME`: string
    * `CMD`: String

## Container Resource Usage

Both the time, and date/memory label and format, will be formatted to match your API user's timezone and locale.

### CPU Usage

`GET /api/containers/{container-id}/metrics/cpu`

**OAuth AuthorizationRequired**: `projects_read`

* `stats`: Array

??? example "Example"
    ```json
    {
        "stats": [
            [ "2021-03-11T21:55:51.000+00:00", 0.22]
        ]
    }
    ```

### Memory Usage

`GET /api/containers/{container-id}/metrics/memory`

**OAuth AuthorizationRequired**: `projects_read`

* `stats`: Array

??? example "Example"
    ```json
    {
        "stats": [
            [ "2021-03-11T21:55:51.000+00:00", 9]
        ]
    }
    ```