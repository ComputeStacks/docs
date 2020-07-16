---
title: Rename Region
description: Process to modify a region name
---
# Renaming a Region

The process of renaming a region requires a few addition steps beyond simply changing the name in the web administrator. This is because we use this to target our key/value store on the nodes, and so that will need to be updated manually.

## Step 1: Bring Down Cluster Manager

### Stop Agent
SSH into each node and run: `systemctl stop cs-agent`

### Break Cluster

You will need to determine the current cluster leader before proceeding. To do so, on one of the nodes run `consul info`. Under the `consul` section, you will see the leader.

!!! example "On all nodes, except the leader, run the following"

    ```bash
    consul leave
    systemctl stop consul
    ```

Verify all members have been evicted by running `consul members` on the leader node.

!!! example "Evict the leader"

    ```bash
    consul leave
    systemctl stop consul
    ```

## Step 2: Update Name
On each node, update the datacenter name to match the name of the new region:

!!! danger ""
    The datacenter name should be one word, all lower case.

```bash
sed -i 's/"datacenter":.*/"datacenter":"NEW-NAME",/g' /etc/consul/config.json
```

## Step 3: Bring Up Cluster

On the leader node, bring up consul with `systemctl start consul`. 

!!! note ""
    Use `consul monitor` and `consul info` to ensure that no errors exist.

Upon successful boot, run that same command across all nodes in your cluster

Verify all members have joined with `consul members`

Finally, run `systemctl start cs-agent` on all nodes in the cluster.

## Step 4: Rename Region in ComputeStacks

Rename the region in ComputeStacks.

