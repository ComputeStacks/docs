# Image Collections

## Create Collection

`POST /api/admin/image_collections`

??? abstract "Schema"
    - `image_collection`: Object
        - `label`: String
        - `active`: Boolean
        - `sort`: Integer | How it's sorted on the order form
        - `container_image_ids`: `Array<Integer>` | List of image IDs
        

---

## Update Collection

`PATCH /api/admin/image_collections/{id}`

??? abstract "Schema"
    - `image_collection`: Object
        - `label`: String
        - `active`: Boolean
        - `sort`: Integer | How it's sorted on the order form
        - `container_image_ids`: `Array<Integer>` | List of image IDs
