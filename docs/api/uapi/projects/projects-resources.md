# Projects: Resources

## Bastion

### List Bastions

SSH/SFTP Containers

`GET /api/projects/{project-id}/bastions`

**OAuth authorization required**: `project_read`

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

### Reset Bastion Password

`POST /api/projects/{project-id}/bastions/{id}/reset_password`

**OAuth authorization required**: `project_write`

Generates a new password and rebuilds the bastion (SSH) container. The rebuild
disconnects any open SSH, SFTP, and cloud shell sessions, and the new password takes
effect once the rebuild completes. Host keys are kept, so clients do not see a
changed-key warning. The password is rotated even while password auth (`pw_auth`) is
disabled.

The SSH port and the project's volumes are unchanged.

Responds with `202 Accepted`, the `event_id` of the rebuild, and the bastion, including
its new password.

If the rebuild cannot be started (for example, the node is offline or another action is
in progress on the bastion), the password is left unchanged and the response is
`422 Unprocessable Entity` with `errors`. The callback is normally not called in that
case. If the rebuild is refused after its event was created, for example because another
action started at the same moment, the event is canceled and the callback reports the
failure. A `callback` that isn't an object with a string `url` is also rejected with
`422`.

??? abstract "Request"
    - `callback`: Object | Optional. Notified when the rebuild finishes, whether it succeeded or failed, so you can tell when the new password is live.
        - `url`: String
        - `authorization`: String | Optional.

??? abstract "Schema"
    - `event_id`: Integer | The rebuild event.
    - `bastion`: Object
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
        - `password`: String | The new password.

## Containers

`GET /api/projects/{project-id}/containers`

**OAuth authorization required**: `project_read`

**Schema**

- `containers`: `Array<Container>`

## Events

`GET /api/projects/{project-id}/events`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `event_log`: Array
        - `id`: Integer
        - `locale`: String
        - `status`: String
        - `notice`: Boolean
        - `state_reason`: String
        - `event_code`: String
        - `description`: String
        - `created_at`: DateTime
        - `updated_at`: DateTime
        - `audit`: Object
            - `id`: Integer
            - `ip_addr`: String
            - `event`: String
            - `raw_data`: String
            - `created_at`: DateTime
            - `updated_at`: DateTime
            - `user`: Object
                - `id`: Integer
                - `name`: String

## Images

`GET /api/project/{project-id}/images`

**OAuth authorization required**: `project_read`

**Schema**

- `container_images`: `Array<ContainerImage>`

## Services

`GET /api/projects/{project-id}/services`

**OAuth authorization required**: `project_read`

**Schema**

- `container_services`: `Array<ContainerService>`
- `container_images`: `Array<ContainerImage>`
