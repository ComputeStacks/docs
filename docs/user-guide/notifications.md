# Notifications

ComputeStacks offers hooks into key events, which allow you to receive notifications on various channels.

## Available Notifications

### Users

For end-users, you have access to the following notifications:

| **Name** | **Description** |
| --- | --- |
| ContainerBootFailed | Attempt to automatically recover a container has failed |
| ContainerCreated | Container is created |
| ContainerCpuUsage | Container CPU usage has been above 85% for more than 1 minute |
| ContainerDestroyed | Container has been deleted |
| ContainerMemoryUsage | Container memory usage has been above 85% for more than 1 minute |

### Administrators

This is in addition to the notifications available to users.

| **Name** | **Description** |
| --- | --- |
| NewOrder | A new order is receive |
| UserActivated | A user is unsuspended |
| UserCreated | A user is created |
| UserDeleted | A user is deleted |
| UserSuspended | A user is suspended |
| DiskWillFillIn4Hours | A disk on a node will be full in *4 hours* at the current rate |
| ExporterDown | A node exporter has failed |
| HighCpuLoad | A node has excessive cpu usage |
| NodeUp | A node has come online |
| OutOfDiskSpace | A node is out of disk space |
| OutOfInodes | A node is out of disk inodes |
| OutOfMemory | A node is out of memory |
| UnusualDiskReadLatency | Unusual disk read latency |
| UnusualDiskWriteLatency | Unusual disk write latency |

## Notification Channels

### Email

Sends an email to the specified address

### Google Chat

To generate a webhook url, navigate to your google chat room and select the dropdown icon next to the room name; select *Manage webhooks*.

### Keybase

To generate a webhook url, navigate to the chat room and click the `(i)` icon in the upper right-hand corner. Choose 'Bots' and add the *Webhook Bot*.

### Matrix

!!! note ""
New to Matrix? We recommend deploying your own Matrix installation using this [ansible playbook](https://github.com/spantaleev/matrix-docker-ansible-deploy){: target="_blank" }.

Our integration was designed to work with the [appservice-webhooks](https://github.com/turt2live/matrix-appservice-webhooks) bridge.

If you're using the ansible playbook listed above to manage your Matrix installation, you may use [these instructions](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/configuring-playbook-bridge-appservice-webhooks.md) to get this setup.

### Microsoft Teams

*This integration is in beta, please share your feedback!*

Send webhook to a Microsoft Teams channel. [Learn More](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook#add-an-incoming-webhook-to-a-teams-channel)

### Slack

Uses the standard [incoming webhook](https://api.slack.com/messaging/webhooks) integration.

### Webhook

Sends a `json` `POST` request to an endpoint of your choice.

Your endpoint must respond with a `20x` http code, otherwise we will continue to send the notification.

The message we send will be formatted with markdown formatting. Specifically, we use `*` to denote bold fields, and `\\n` to denote new lines.

```json
{
    "text": "*Sample Description*\\n<http://url.to.alert|View Alert>\\n*Container:* container-name-123\\n*Label:* Value"
}

```
