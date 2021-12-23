# Regions

## List All Regions

`GET /api/admin/locations/{location_id}/regions`

??? abstract "Schema"
    * `regions`: Array
        * `id`: Integer
        * `name`: String
        * `active`: Boolean
        * `fill_to`: Integer
        * `volume_backend`: String - local or nfs
        * `nfs_remote_host`: String - IP Address of NFS server when connecting from the node
        * `nfs_remote_path`: String - path to nfs volume on remote server. the volume name will be appended to this, so dont add trailing slash.
        * `nfs_controller_ip`: String - IP Address of NFS Server when connecting from the controller
        * `offline_window`: Integer - In seconds, how long do we wait after the last heartbeat before consider this node offline?
        * `failure_count`: Integer - How many times do we attempt to connect back to the node to verify it's really offline before migrating it's containers to other nodes
        * `loki_endpoint`: String
        * `loki_retries`: String
        * `loki_batch_size`: String
        * `loki_client_id`: Integer
        * `metric_client_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## View Region

`GET /api/admin/locations/{location_id}/regions/{id}`

??? abstract "Schema"
    * `regions`: Object
        * `id`: Integer
        * `name`: String
        * `active`: Boolean
        * `fill_to`: Integer
        * `volume_backend`: String - local or nfs
        * `nfs_remote_host`: String - IP Address of NFS server when connecting from the node
        * `nfs_remote_path`: String - path to nfs volume on remote server. the volume name will be appended to this, so dont add trailing slash.
        * `nfs_controller_ip`: String - IP Address of NFS Server when connecting from the controller
        * `offline_window`: Integer - In seconds, how long do we wait after the last heartbeat before consider this node offline?
        * `failure_count`: Integer - How many times do we attempt to connect back to the node to verify it's really offline before migrating it's containers to other nodes
        * `loki_endpoint`: String
        * `loki_retries`: String
        * `loki_batch_size`: String
        * `loki_client_id`: Integer
        * `metric_client_id`: Integer
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Update Region

`PATCH /api/admin/locations/{location_id}/regions/{id}`

_Note: You may not update the name of an existing region. In a future update we will make that change possible._

??? abstract "Schema"
    * `regions`: Array
        * `active`: Boolean
        * `fill_to`: Integer
        * `volume_backend`: String - local or nfs
        * `nfs_remote_host`: String - IP Address of NFS server when connecting from the node
        * `nfs_remote_path`: String - path to nfs volume on remote server. the volume name will be appended to this, so dont add trailing slash.
        * `nfs_controller_ip`: String - IP Address of NFS Server when connecting from the controller
        * `offline_window`: Integer - In seconds, how long do we wait after the last heartbeat before consider this node offline?
        * `failure_count`: Integer - How many times do we attempt to connect back to the node to verify it's really offline before migrating it's containers to other nodes
        * `loki_endpoint`: String
        * `loki_retries`: String
        * `loki_batch_size`: String
        * `loki_client_id`: Integer
        * `metric_client_id`: Integer


## Create Region

`POST /api/admin/locations/{location_id}/regions`

??? abstract "Schema"
    * `regions`: Object
        * `name`: String
        * `active`: Boolean
        * `fill_to`: Integer
        * `volume_backend`: String - local or nfs
        * `nfs_remote_host`: String - IP Address of NFS server when connecting from the node
        * `nfs_remote_path`: String - path to nfs volume on remote server. the volume name will be appended to this, so dont add trailing slash.
        * `nfs_controller_ip`: String - IP Address of NFS Server when connecting from the controller
        * `offline_window`: Integer - In seconds, how long do we wait after the last heartbeat before consider this node offline?
        * `failure_count`: Integer - How many times do we attempt to connect back to the node to verify it's really offline before migrating it's containers to other nodes
        * `loki_endpoint`: String
        * `loki_retries`: String
        * `loki_batch_size`: String
        * `loki_client_id`: Integer
        * `metric_client_id`: Integer


## Delete Region

`DELETE /api/admin/locations/{location_id}/regions/{id}`
