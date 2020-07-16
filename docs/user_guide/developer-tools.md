---
title: Developer Tools
description: Developer Tools
---
# Developer Tools

## Automating and extending functionality

We offer a full REST API, our current documentation is available [here](https://demo.computestacks.net/documentation/api).

## Metadata Service
To aid in building complex container setups, ComputeStacks provides an easy metadata service to running containers. This allows any running container to authenticate with the ComputeStacks API and access realtime information about all the running services and containers in their project.

Here is an example `curl` request that can be run from any container:

```bash
curl -H "Content-Type: application/json" -H "Authorization: Bearer ${METADATA_AUTH}" $METADATA_URL
```

??? example "Example Response"


    ```json
    {
      "current_service_id": 449,
      "project": {
        "id": 271,
        "name": "test"
      },
      "services": [
        {
          "id": 449,
          "name": "elated-newton271",
          "label": "elated-newton271",
          "created_at": "2020-01-09T23:29:24.161Z",
          "updated_at": "2020-01-09T23:29:32.946Z",
          "domains": [
            "elated-newton271217.a.cs.local"
          ],
          "image": {
            "id": 131,
            "label": "nginx",
            "role": "nginx",
            "category": "web",
            "tags": []
          },
          "containers": [
            {
              "id": 465,
              "name": "elated-newton271-480",
              "ip": "10.100.0.116"
            }
          ],
          "ingress_rules": [
            {
              "proto": "http",
              "port": 80,
              "external_access": true,
              "backend_ssl": false,
              "tcp_proxy_opt": "none",
              "nat": null
            }
          ],
          "settings": [
            {
              "id": 448,
              "name": "some_param",
              "label": "My Param",
              "param_type": "static",
              "decrypted_value": "my param",
              "created_at": "2020-01-09T22:16:32.600Z",
              "updated_at": "2020-01-09T22:16:32.600Z"
            }
          ]
        }
      ]
    }
    ```

## Authentication and Single Sign On (SSO)

ComputeStacks includes an OAuth2 authentication system which allows you to build custom applications that allow endusers to authenticate directly with ComputeStacks. More information is available in our API Documentation