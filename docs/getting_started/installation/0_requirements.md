---
title: Planning Your Installation
description: Planning Your Installation
---
# Planning Your Installation

Before proceeding, we recommend you first review our [Architecture Overview](../architecture_overview.md) page.

Our installation process requires [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html){: target="_blank" } to be installed either locally on your computer, or remotely on a linux machine. Please ensure this has been setup prior to continuing with this installation process.

## License Key

You may purchase, or request a free demo license key, here: [computestacks.com/pricing](https://www.computestacks.com/pricing){: target="_blank" }


## Supported Linux Distribution

Our supported linux distribution is **Debian 10 Buster**.

## Domain Names

Having your domain names setup is a critical part of the installation process.

The following roles will require domain names:

<table>
<tbody>
    <tr>
        <td><b>Controller</b></td>
        <td>this is the main URL for the service. Examples include: portal, dashboard, cp,...</td>
    </tr>
    <tr>
        <td><b>Container Registry</b></td>
        <td>We recommend a shorter URL like cr, registry, ...</td>
    </tr>
    <tr>
        <td><b>Metrics</b></td>
        <td>
            For our log aggregation service and container metrics. This can be <code>metrics.region.example.com</code>, or something like that. We generally recommend that each region have their own metrics server and, ideally, accessible over private networks. We ask for a domain to generate an ACME certificate, and will then hard code the private IPs internally.
        </td>
    </tr>
    <tr>
        <td><b>App URL</b></td>
        <td>
            This is the default URL we use to generate domains for each service <em>(container)</em>. This can be something like <code>a.region.example.com</code>. 
            <br><br>
            <em>Each Availability zone will need to have their own domain, which is why I recommend including the region and AZ in the URL. For example, if you have regions in Amsterdam and Frankfurt, you could use something like this:</em>
            <br>
            <pre>
a.ams.example.net <-- Availability Zone 1
b.ams.example.net <-- Availability Zone 2
a.fra.example.net
b.fra.example.net
            </pre>
        </td>
    </tr>
</tbody>
</table>

??? example "Example DNS Records"

    ```
    a.dev.cmptstks.net. IN A %{floating_ip}
    metrics.dev.cmptstks.net. IN A %{PUBLIC IP OF METRICS SERVER}
    *.a.dev.cmptstks.net. IN CNAME a.dev.cmptstks.net.
    portal.dev.cmptstks.net. IN A %{controller ip address}
    cr.dev.cmptstks.net. IN CNAME portal.dev.cmptstks.net.
    ```

## Choosing a DNS Server

We require a DNS integration for our platform; there are two supported options:

1. Use our free hosted DNS service, or; 
2. Host your own PowerDNS servers.

During installation, the default will be to use a shared demo account. Please contact us for your hosted dns credentials, or for help setting up your own PowerDNS cluster.

## Linux Users and Groups

Our container nodes depend on having UID & GID `1001` available for our use. This is generally not a problem on most cloud and virtual machine images, however if you performed some pre-installation steps that included creating a user, this UID/GID may be already taken. 

Please change the UID and GID of the user who took that ID before proceeding. [Here is a guide](https://kerneltalks.com/tips-tricks/how-to-change-uid-or-gid-safely-in-linux/){: target="_blank" } to help you accomplish this.

You can verify that this is available by running the following commands on the container nodes:

```bash
cat /etc/passwd | grep 1001
cat /etc/group | grep 1001
```

## Network Setup
At a minimum, we require a single public IP Address _per server_. 

However, the recommended network configuration for each server is: 1 Public, 1 Private. Each server should be able to communicate over the private network.

!!! danger ""
    Please ensure that the container node does not have any kind of source/destination filtering on it's private network interface. If this is not possible, you will need to set `calico_network_ipip` to `true` when building your ansible inventory

For clusters (3+ container nodes), we will also require a _Floating IP Address_. We will use arp to announce that ip on one of the 3 nodes, and handle failover automatically through corosync and pacemaker.


## Disk Setup
If you have the option to select the partition layout for the container nodes, please place most of your disk storage at `/var/lib/docker`. You can skip a dedicated `/home` partition, as this is not used in our environment.

??? example "Example Disk Layout"

    ```
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/sda        100G  3.5G  96GB   1% /
    /dev/sdb        1.5T   14G  1.5T   1% /var/lib/docker
    /dev/sdc        487M   94M  368M  21% /boot
    ```

## Minimum Server Requirements

All CPU Cores should be newer x86 2Ghz+ Intel or AMD processors.

!!! tip ""
    See more example configurations [here](../architecture_overview.md#example-configurations).

!!! abstract "Testing Environment"

    Name           | CPU     | Memory | Disk
    ---------------|---------|--------|------
    Controller     | 4 Cores | 8 GB   | 50 GB
    Container Node | 2 Core  | 4 GB   | 50 GB

!!! abstract "Production Environment"

    Name           | CPU     | Memory | Disk
    ---------------|---------|--------|-----------------------------------------------------
    Controller     | 4 Cores | 8 GB   | 50 GB
    Backup Server  | 1 Core  | 1 GB   | Start with 50% of total disk capacity in the cluster
    Container Node | 4 Core  | 12 GB  | 100 GB
    Metrics Server | 4 Core  | 8 GB   | 25 GB

---
Next Step: [Preparing Installation Resources](1_prepare.md)
