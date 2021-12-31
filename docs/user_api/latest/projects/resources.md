# Project Resources

## Bastion

### List Bastions

SSH/SFTP Containers

`GET /api/projects/{project-id}/bastions`

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

### Reset Bastion Password

`POST /api/projects/{project-id}/bastions/{id}/reset_password`

**OAuth AuthorizationRequired**: `projects_write`

## Containers

`GET /api/projects/{project-id}/containers`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `containers`: `Array<Container>`

## Events

`GET /api/projects/{project-id}/events`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `event_log`: Array
        * `id`: Integer
        * `locale`: String
        * `status`: String
        * `notice`: Boolean
        * `state_reason`: String
        * `event_code`: String
        * `description`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime
        * `audit`: Object
            * `id`: Integer
            * `ip_addr`: String
            * `event`: String
            * `raw_data`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime
            * `user`: Object
                * `id`: Integer
                * `name`: String

## Images

`GET /api/project/{project-id}/images`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `container_images`: `Array<ContainerImage>`

## Services

`GET /api/projects/{project-id}/services`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `container_services`: `Array<ContainerService>`
    * `container_images`: `Array<ContainerImage>`