---
title: Products
description: Products API
---
# Products

## List Products

`GET /api/admin/products`

??? abstract "Schema"
    * `products`: Array
        * `id`: Integer
        * `label`: String
        * `resource_kind`: String - backup,bandwidth,cpu,ipaddr,memory,storage,local_disk (only for non-packages)
        * `unit`: Integer - (only for non-packages)
        * `unit_type`: String - (only for non-packages)
        * `package`: Object
            * `id`: Integer
            * `cpu`: Decimal - CPU Cores (supports fractional cores as decimal)
            * `memory`: String - MB
            * `memory_swap`: Integer - Amount of memory (MB) allowed to swap to disk.
            * `memory_swappiness`: Integer between 1 and 100 (default 60).
            * `bandwidth`: Integer - Included bandwidth (GB)
            * `storage`: Integer - Volume Storage (GB)
            * `local_disk`: Integer - Temporary / Local Disk storage (GB)
            * `backup`: Integer - Included backup storage (GB)
        * `created_at`: DateTime
        * `updated_at`: DateTime

## View Product

`GET /api/admin/products/{id}`

??? abstract "Schema"
    * `product`: Object
        * `id`: Integer
        * `label`: String
        * `resource_kind`: String - backup,bandwidth,cpu,ipaddr,memory,storage,local_disk (only for non-packages)
        * `unit`: Integer - (only for non-packages)
        * `unit_type`: String - (only for non-packages)
        * `package`: Object
            * `id`: Integer
            * `cpu`: Decimal - CPU Cores (supports fractional cores as decimal)
            * `memory`: String - MB
            * `memory_swap`: Integer - Amount of memory (MB) allowed to swap to disk.
            * `memory_swappiness`: Integer between 1 and 100 (default 60).
            * `bandwidth`: Integer - Included bandwidth (GB)
            * `storage`: Integer - Volume Storage (GB)
            * `local_disk`: Integer - Temporary / Local Disk storage (GB)
            * `backup`: Integer - Included backup storage (GB)
        * `created_at`: DateTime
        * `updated_at`: DateTime


## Update Product

`PATCH /api/admin/products/{id}`

Be aware that updating a package through this will completly delete the package, and re-create it with the values you provide. Be sure to supply _all_ values for the package. To only update the product, and not the package, omit the `package_attributes` object.

??? abstract "Schema"
    * `product`: Object
        * `label`: String
        * `resource_kind`: String - backup,bandwidth,cpu,ipaddr,memory,storage,local_disk (only for non-packages)
        * `unit`: Integer - (only for non-packages)
        * `unit_type`: String - (only for non-packages)
        * `package`: Object
            * `id`: Integer
            * `cpu`: Decimal - CPU Cores (supports fractional cores as decimal)
            * `memory`: String - MB
            * `memory_swap`: Integer - Amount of memory (MB) allowed to swap to disk.
            * `memory_swappiness`: Integer between 1 and 100 (default 60).
            * `bandwidth`: Integer - Included bandwidth (GB)
            * `storage`: Integer - Volume Storage (GB)
            * `local_disk`: Integer - Temporary / Local Disk storage (GB)
            * `backup`: Integer - Included backup storage (GB)

## Create Product

`POST /api/admin/products`

Be sure to add products to billing plans and create price rules.

??? abstract "Schema"
    * `product`: Object
        * `label`: String
        * `resource_kind`: String - backup,bandwidth,cpu,ipaddr,memory,storage,local_disk (only for non-packages)
        * `unit`: Integer - (only for non-packages)
        * `unit_type`: String - (only for non-packages)
        * `package`: Object
            * `id`: Integer
            * `cpu`: Decimal - CPU Cores (supports fractional cores as decimal)
            * `memory`: String - MB
            * `memory_swap`: Integer - Amount of memory (MB) allowed to swap to disk.
            * `memory_swappiness`: Integer between 1 and 100 (default 60).
            * `bandwidth`: Integer - Included bandwidth (GB)
            * `storage`: Integer - Volume Storage (GB)
            * `local_disk`: Integer - Temporary / Local Disk storage (GB)
            * `backup`: Integer - Included backup storage (GB)


## Delete Product

`DELETE /api/admin/products/{id}`
