---
title: Webhooks
description: Webhooks
---
# Webhooks

ComputeStacks offers administrators a few different web hook options. All of these can be set in the admin under **Settings**. 

To accept the web hook, your system must return a status code `202 ACCEPTED`. Otherwise, our system will retry the web hook (up to 5 times). The retry schedule is as follows:

- First: One minute later
- Second: 15 minutes later
- Third - Fifth: Every hour.

## Billing Events

These web hooks are triggered immediately when the event occurs, so depending on your environment, this could be many 

- New subscriptions (new orders)
- Resizing
- Cancelling subscription
- Scaling container service
- Automatic phase transitions

## Billing Usage

This hook is for the aggregated billing usage that's processed on the last day of the month. 

Here is an example output:

```json
[
    {
        "billing_resource": {
            "billing_plan_id": 3,
            "external_id": "",
            "id": 12
        },
        "container_id": 65,
        "container_service_id": 53,
        "device_id": null,
        "external_id": null,
        "period_end": "2018-08-01 16:59:59 UTC",
        "period_start": "2018-06-30 23:00:00 UTC",
        "product": {
            "external_id": "",
            "id": 6,
            "name": "Container XS"
        },
        "qty": 762.0,
        "subscription_id": 59,
        "subscription_product_id": 175,
        "total": 3.048,
        "user": {
            "email": "user@example.com",
            "external_id": "1",
            "id": 8
        }
    }
]
```