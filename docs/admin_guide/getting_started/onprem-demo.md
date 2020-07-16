---
title: OnPrem Demo
description: Requirements for OnPrem Demo
---
# On-Premise Demo Requirements

!!! note ""
    Please review our [architecture overview](architecture_overview.md) for a full production setup.

Our demo requirements are very basic, we simply need two CentOS 7 virtual machines with sufficient resources, and a single public IP per server.

Role           | OS       | Memory | CPU     | Disk      | Disk Layout
---------------|----------|--------|---------|-----------|------------------------------------------------------------------------------------
Controller     | CentOS 7 | 8GB    | 4 Cores | 50GB Disk | Custom partition with all storage at `/`
Container Node | CentOS 7 | 8GB    | 4 Cores | 50GB      | Custom partition with all storage at `/`, or, the bulk can be at `/var/lib/docker`.

{% include 'ssh_key.md' %}

### Additional Notes

* Please provide a single public IP to each server
* Ensure that `SELinux` remains enabled.
    * Our installation process will enable it if it's disabled.
* Please only have the `root` user configured. As part of the installation process we will lock this account down.
    * If your internal policies do not allow this, then please make sure the container node's non-root user does not use UID/GID `1001`.