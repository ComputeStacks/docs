# Nodes

## List All Nodes

`GET /api/admin/locations/{location_id}/regions/{region_id}/nodes`

??? abstract "Schema"
    * `nodes`: Array
        * `id`: String
        * `label`: String
        * `hostname`: String
        * `primary_ip`: String
        * `disconnected`: Boolean
        * `failed_health_checks`: Integer
        * `active`: Boolean
        * `online_at`: DateTime
        * `disconnected_at`: DateTime
        * `public_ip`: String
        * `region_id`: Integer
        * `maintenance`: Boolean
        * `maintenance_updated`: DateTime
        * `job_status`: String
        * `ssh_port`: Integer
        * `volume_device`: String
        * `block_write_bps`: Integer
        * `block_read_bps`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Node

`GET /api/admin/locations/{location_id}/regions/{region_id}/nodes/{id}`

??? abstract "Schema"
    * `node`: Object
        * `id`: String
        * `label`: String
        * `hostname`: String
        * `primary_ip`: String
        * `disconnected`: Boolean
        * `failed_health_checks`: Integer
        * `active`: Boolean
        * `online_at`: DateTime
        * `disconnected_at`: DateTime
        * `public_ip`: String
        * `region_id`: Integer
        * `maintenance`: Boolean
        * `maintenance_updated`: DateTime
        * `job_status`: String
        * `ssh_port`: Integer
        * `volume_device`: String
        * `block_write_bps`: Integer
        * `block_read_bps`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Update Node

`PATCH /api/admin/locations/{location_id}/regions/{region_id}/nodes/{id}`

_Note: We currently do not allow changing the hostname of an existing node._

??? abstract "Schema"
    * `node`: Object
        * `label`: String
        * `primary_ip`: String
        * `active`: Boolean
        * `public_ip`: String
        * `region_id`: Integer
        * `ssh_port`: Integer
        * `volume_device`: String
        * `block_write_bps`: Integer
        * `block_read_bps`: Integer

## Create Node

`POST /api/admin/locations/{location_id}/regions/{region_id}/nodes`

??? abstract "Schema"
    * `node`: Object
        * `label`: String
        * `hostname`: String
        * `primary_ip`: String
        * `active`: Boolean
        * `public_ip`: String
        * `region_id`: Integer
        * `ssh_port`: Integer
        * `volume_device`: String
        * `block_write_bps`: Integer
        * `block_read_bps`: Integer

## Delete Node

`DELETE /api/admin/locations/{location_id}/regions/{region_id}/nodes/{id}`

---

## Maintenance Mode

### Enable

`POST /api/admin/locations/{location_id}/regions/{region_id}/nodes/{node_id}/maintenance`

!!! danger ""
    **Warning** This will evacuate all containers that are not using local volumes to other nodes in the region (Availability-Zone).

Returns `HTTP 202 Accepted` if successful.


### Disable

`DELETE /api/admin/locations/{location_id}/regions/{region_id}/nodes/{node_id}/maintenance`

Returns `HTTP 202 Accepted` if successful.
