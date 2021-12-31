# Event Logs API

Please see individual resources for their specific endpoint to list events. This is currently only used to view a single event and it's details.

## View Event Log

`GET /api/event_logs/{id}`

**OAuth AuthorizationRequired**: `projects_read`

??? abstract "schema"
    * `event_log`: Object
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
        * `event_details`: Array
            * `id`: Integer
            * `data`: String
            * `event_code`: String
            * `created_at`: DateTime
            * `updated_at`: DateTime