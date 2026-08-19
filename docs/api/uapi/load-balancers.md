# Load Balancers

Returns the available products and pricing for your current user

## List all available products

`GET /api/products`

**OAuth authorization required**: `project_read`

??? abstract "Schema"
    - `products`: Array
        - `id`: Integer
        - `name`: String
        - `price`: String
        - `cpu`: Decimal
        - `term`: `String<hour,month,year>`
        - `memory`: Integer
        - `bandwidth`: Integer
        - `storage`: Integer
        - `ipaddr`: Integer
        - `backup`: Integer
        - `swap`: Integer
        - `region`: Integer
