---
title: Upgrade Agent
description: Upgrade Node Agent
---
# Upgrade Node Agent

!!! danger ""
    Before proceeding, ensure there are no backup jobs currently running. You can do that by first looking for any `backup-XXX` containers running, and also looking at the logs with `journalctl -b -u cs-agent.service`

On each node, run the following:

```bash
systemctl stop cs-agent
cd /tmp && wget https://cdn.computestacks.net/packages/cs-agent/cs-agent.tar.gz
tar -xzvf cs-agent.tar.gz
rm -f /usr/local/bin/cs-agent
mv cs-agent /usr/local/bin/
chown root:root /usr/local/bin/cs-agent && chmod +x /usr/local/bin/cs-agent
rm -rf /tmp/cs-agent*
```

!!! tip ""
    If you are making changes to the `nfs_` params in the agent configuration file (`/etc/computestacks/agent.yaml`), then be sure to delete all existing backup volumes before starting: `docker volume rm $(docker volume ls -q --filter label="com.computestacks.role=backup")`

```bash
systemctl start cs-agent
```