# Locations

## List All Locations

`GET /api/admin/locations`

??? abstract "Schema"
    * `locations`: Array
        * `id`: Integer
        * `name`: String
        * `fill_strategy`: String - `least` or `full`. `Full` will fill to the `fill_to` variable on the region (AZ).
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Location

`GET /api/admin/locations/{id}`

??? abstract "Schema"
    * `location`: Object
        * `id`: Integer
        * `name`: String
        * `fill_strategy`: String - `least` or `full`. `Full` will fill to the `fill_to` variable on the region (AZ).
        * `created_at`: DateTime
        * `updated_at`: DateTime

## Update Location

`PATCH /api/admin/locations/{id}`

??? abstract "Schema"
    * `location`: Object
        * `name`: String
        * `fill_strategy`: String - `least` or `full`. `Full` will fill to the `fill_to` variable on the region (AZ).

## Create Location

`POST /api/admin/locations`

??? abstract "Schema"
    * `location`: Object
        * `name`: String
        * `fill_strategy`: String - `least` or `full`. `Full` will fill to the `fill_to` variable on the region (AZ).


## Delete Location

`DELETE /api/admin/locations/{id}`
