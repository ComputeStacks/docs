---
title: Notifications
description: Managing ComputeStacks
---
# Notifications

ComputeStacks offers hooks into key events, which allow you to receive notifications on various channels.

## Available Notifications

### Users

For end-users, you have access to the following notifications:

<table>
<tbody>
    <tr>
        <td><b>ContainerBootFailed</b></td>
        <td>Attempt to automatically recover a container has failed</td>
    </tr>
    <tr>
        <td><b>ContainerCreated</b></td>
        <td>Container is created</td>
    </tr>
    <tr>
        <td><b>ContainerCpuUsage</b></td>
        <td>Container CPU usage has been above 85% for more than 1 minute</td>
    </tr>
    <tr>
        <td><b>ContainerDestroyed</b></td>
        <td>Container has been deleted</td>
    </tr>
    <tr>
        <td><b>ContainerMemoryUsage</b></td>
        <td>Container memory usage has been above 85% for more than 1 minute</td>
    </tr>
</tbody>
</table>

### Administrators

_This is in addition to the notifications available to users._

<table>
<tbody>
    <tr>
        <td><b>NewOrder</b></td>
        <td>A new order is received</td>
    </tr>
    <tr>
        <td><b>UserActivated</b></td>
        <td>A user is unsuspended</td>
    </tr>
    <tr>
        <td><b>UserCreated</b></td>
        <td>A user is created</td>
    </tr>
    <tr>
        <td><b>UserDeleted</b></td>
        <td>A user is deleted</td>
    </tr>
    <tr>
        <td><b>UserSuspended</b></td>
        <td>A user is suspended</td>
    </tr>
    <tr>
        <td><b>DiskWillFillIn4Hours</b></td>
        <td>A disk on a node will be full in <em>4 hours</em> at the current rate</td>
    </tr>
    <tr>
        <td><b>ExporterDown</b></td>
        <td>A node exporter has failed</td>
    </tr>
    <tr>
        <td><b>HighCpuLoad</b></td>
        <td>A node has excessive cpu usage</td>
    </tr>
    <tr>
        <td><b>NodeUp</b></td>
        <td>A node has come online</td>
    </tr>
    <tr>
        <td><b>OutOfDiskSpace</b></td>
        <td>A node is out of disk space</td>
    </tr>
    <tr>
        <td><b>OutOfInodes</b></td>
        <td>A node is out of disk inodes</td>
    </tr>
    <tr>
        <td><b>OutOfMemory</b></td>
        <td>A node is out of memory</td>
    </tr>
    <tr>
        <td><b>UnusualDiskReadLatency</b></td>
        <td>Unusual disk read latency</td>
    </tr>
    <tr>
        <td><b>UnusualDiskWriteLatency</b></td>
        <td>Unusual disk write latency</td>
    </tr>
</tbody>
</table>

## Notification Channels

### Email

Sends an email to the specified address

### Google Chat

To generate a webhook url, navigate to your google chat room and select the dropdown icon next to the room name; select _Manage webhooks_.

### Keybase

To generate a webhook url, navigate to the chat room and click the `(i)` icon in the upper right-hand corner. Choose 'Bots' and add the _Webhook Bot_. 

### Matrix

!!! note ""
    New to Matrix? We recommend deploying your own Matrix installation using this [ansible playbook](https://github.com/spantaleev/matrix-docker-ansible-deploy){: target="_blank" }.

Our integration was designed to work with the [appservice-webhooks](https://github.com/turt2live/matrix-appservice-webhooks){: target="_blank" } bridge. 

If you're using the ansible playbook listed above to manage your Matrix installation, you may use [these instructions](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/configuring-playbook-bridge-appservice-webhooks.md){: target="_blank" } to get this setup.

### Microsoft Teams

!!! warning ""
    This integration is in beta, please share your feedback!

Send webhook to a Microsoft Teams channel. [Learn More](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook#add-an-incoming-webhook-to-a-teams-channel){: target="_blank" }

### Slack

Uses the standard [incoming webhook](https://api.slack.com/messaging/webhooks){: target="_blank" } integration.

### Webhook

Sends a `json` `POST` request to an endpoint of your choice.

!!! success ""
    Your endpoint must respond with a `20x` http code, otherwise we will continue to send the notification.

The message we send will be formatted with markdown formatting. Specifically, we use `*` to denote bold fields, and `\n` to denote new lines.

```json
{ 
    "text": "*Sample Description*\n<http://url.to.alert|View Alert>\n*Container:* container-name-123\n*Label:* Value" 
}
```