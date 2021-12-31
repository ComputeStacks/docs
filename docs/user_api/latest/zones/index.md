# DNS Zones

## List all zones

`GET /api/zones`

**OAuth AuthorizationRequired**: `dns_read`

??? abstract "schema"
    * `zones`: Array
        * `id`: Integer
        * `name`: String
        * `created_at`: DateTime
        * `updated_at`: DateTime



## View zone

`GET /api/zones/{id}`

**OAuth AuthorizationRequired**: `dns_read`

??? abstract "schema"
    * `zone`:
        * `id`: Integer
        * `name`: String
        * `records`: Object
            * `A`: Array
            * `...`
        * `created_at`: DateTime
        * `updated_at`: DateTime

??? example "Example"
    ```json
    {
      "zone": {
        "id": 2,
        "name": "mytestdomain.net",
        "created_at": "2019-08-26T17:22:39.333Z",
        "updated_at": "2019-08-26T17:22:39.333Z",
        "records": {
          "A": [],
          "AAAA": [],
          "CAA": [],
          "CNAME": [],
          "DS": [],
          "HINFO": [],
          "MX": [],
          "NAPTR": [],
          "NS": [
            {
              "ttl": 86400,
              "zone_id": "mytestdomain.net",
              "type": "NS",
              "name": "mytestdomain.net",
              "hostname": "ns1.auto-dns.com"
            },
            {
              "ttl": 86400,
              "zone_id": "mytestdomain.net",
              "type": "NS",
              "name": "mytestdomain.net",
              "hostname": "ns2.auto-dns.com"
            },
            {
              "ttl": 86400,
              "zone_id": "mytestdomain.net",
              "type": "NS",
              "name": "mytestdomain.net",
              "hostname": "ns3.autodns.nl"
            },
            {
              "ttl": 86400,
              "zone_id": "mytestdomain.net",
              "type": "NS",
              "name": "mytestdomain.net",
              "hostname": "ns4.autodns.nl"
            }
          ],
          "PTR": [],
          "SRV": [],
          "SOA": [
            {
              "ttl": 86400,
              "zone_id": "mytestdomain.net",
              "type": "SOA",
              "refresh": 43200,
              "retry": 7200,
              "expire": 1209600,
              "email": "dns@usr.cloud",
              "default": 86400
            }
          ],
          "SSHFP": [],
          "TLSA": [],
          "TXT": []
        }
      }
    }
    ```
