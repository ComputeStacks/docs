# How-To: Resource Management

ComputeStacks offers multiple ways to restrict resource consumption by individual containers.

## Container Packages

CPU, Memory, and Swap usage can be limited by defining those values within the [container package](../billing/plans.md).

| Parameter | Default | Description |
| --- | --- | --- |
| OOM Killer | `Enabled` | Enable or Disable the OOM Killer for containers. If disabled, a container may become hung and require manual intervention. |
| PID Limit | `0 (Unlimited)` | Maximum number of active processes allowed inside a container. |
| Max Open Files (Soft) | `0 (Unlimited)` | Soft limit for maximum allowed open files within a container. |
| Max Open Files (Hard) | `0 (Unlimited)` | Hard limit for maximum allowed open files within a container. |

## Node Container Restrictions

!!! danger
    In order for these settings to be applied, you *must* define the `block device path` on the node. This should be set to where `/var/lib/docker` is mounted. Examples include: `/dev/sda1`, `/dev/mapper/hostname--vg-root`.

    Incorrect setting will prevent the container from starting.

| Parameter | Default | Description |
| --- | --- | --- |
| Write Bytes Per Second | `0 (Unlimited)` | Maximum allowed Bytes Per Second written to disk, per container. |
| Write Operations Per Second | `0 (Unlimited)` | Maximum allowed Operations Per Second (IOPS) written to disk, per container. |
| Read Bytes Per Second | `0 (Unlimited)` | Maximum allowed Bytes Per Second read from disk, per container. |
| Read Operations Per Second | `0 (Unlimited)` | Maximum allowed Operations Per Second (IOPS) read from disk, per container. |
