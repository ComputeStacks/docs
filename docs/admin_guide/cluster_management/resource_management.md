---
title: Resource Management
description: Resource Management
---
# Resource Management

ComputeStacks offers multiple ways to restrict resource consumption by individual containers.

## Container Packages

CPU, Memory, and Swap usage can be limited by defining those values within the [container package](../billing/billing_plans.md#package-settings).

!!! danger ""
    Please note: You may only limit disk IO, not usage.

## Availability Zone Container Restrictions

<table>
<thead>
  <tr>
    <th>Parameter</th>
    <th>Default</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
    <tr>
        <td><b>OOM Killer</b></td>
        <td><code>Enabled</code></td>
        <td>Enable or Disable the OOM Killer for containers. If disabled, a container may become hung and require manual intervention.</td>
    </tr>
    <tr>
        <td><b>PID Limit</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Maximum number of active processes allowed inside a container.</td>
    </tr>
    <tr>
        <td><b>Max Open Files (Soft)</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Soft limit for maximum allowed open files within a container.</td>
    </tr>
    <tr>
        <td><b>Max Open Files (Hard)</b></td>        
        <td><code>0 (Unlimited)</code></td>
        <td>Hard limit for maximum allowed open files within a container.</td>
    </tr>
</tbody>
</table>

## Node Container Restrictions

!!! danger ""
    In order for these settings to be applied, you _must_ define the `block device path` on the node. This should be set to where `/var/lib/docker` is mounted. Examples include: `/dev/sda1`, `/dev/mapper/hostname--vg-root`.

    Incorrect setting will prevent the container from starting.

<table>
<thead>
  <tr>
    <th>Parameter</th>
    <th>Default</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
    <tr>
        <td><b>Write Bytes Per Second</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Maximum allowed Bytes Per Second written to disk, per container.</td>
    </tr>
    <tr>
        <td><b>Write Operations Per Second</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Maximum allowed Operations Per Second (IOPS) written to disk, per container.</td>
    </tr>
    <tr>
        <td><b>Read Bytes Per Second</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Maximum allowed Bytes Per Second read from disk, per container.</td>
    </tr>
    <tr>
        <td><b>Read Operations Per Second</b></td>
        <td><code>0 (Unlimited)</code></td>
        <td>Maximum allowed Operations Per Second (IOPS) read from disk, per container.</td>
    </tr>
</tbody>
</table>
