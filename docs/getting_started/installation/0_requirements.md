---
title: Planning Your Installation
description: Planning Your Installation
---
# Planning Your Installation

Before proceeding, we recommend you first review our [Architecture Overview](../architecture_overview.md) page.

Our installation process requires [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html){: target="_blank" } to be installed either locally on your computer, or remotely on a linux machine. Please ensure this has been setup prior to continuing with this installation process.

## Supported Linux Distribution

Our supported linux distribution is **Debian 11 Bullseye**.

## Domain Names

Having your domain names setup is a critical part of the installation process.

The following roles will require domain names:

<table>
<tbody>
    <tr>
        <td><b>Controller</b></td>
        <td>this is the main URL for the service. Examples include: <code>portal</code>, <code>dashboard</code>, or <code>cp</code>.</td>
    </tr>
    <tr>
        <td><b>Container Registry</b></td>
        <td>Examples: <code>cr.</code>, or <code>registry.</code>.</td>
    </tr>
    <tr>
        <td><b>Metrics</b></td>
        <td>
            For our log aggregation service and container metrics. This should be specific to the region it's in, such as: <code>metrics.region.example.com</code>.
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
a.ams.example.net <-- Region AMS, Availability Zone 1
b.ams.example.net <-- Region AMS, Availability Zone 2
a.fra.example.net <-- Region FRA, Availability Zone 1
b.fra.example.net <-- Region FRA, Availability Zone 2
            </pre>
        </td>
    </tr>
    <tr>
        <td><b>PowerDNS</b></td>
        <td>
            <code>ns1/ns2</code>
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

## Linux Users and Groups

Our container nodes depend on having UID & GID `1001` available for our use. This is generally not a problem on most cloud and virtual machine images, however if you performed some pre-installation steps that included creating a user, this UID/GID may be already taken. 

Please change the UID and GID of the user who took that ID before proceeding. [Here is a guide](https://kerneltalks.com/tips-tricks/how-to-change-uid-or-gid-safely-in-linux/){: target="_blank" } to help you accomplish this.

You can verify that this is available by running the following commands on the container nodes:

```bash
cat /etc/passwd | grep 1001
cat /etc/group | grep 1001
```

## Network Setup
Our recommended ip setup is: 1 Public, 1 Private, per server. Please see our [example configurations](../architecture_overview.md#example-configurations) for more details.

!!! danger ""
    Please ensure that the container node does not have any kind of source/destination filtering on it's private network interface. If this is not possible, you will need to set `calico_network_ipip` to `true` in your `inventory.yml` file.

    Typically if you have your own L2 network, this won't be a problem. Where this typically is an issue is in cloud environments, at which case you will need to check if you can disable that. Falling back to `ip-in-ip` tunneling is possible, but not recommended for production environments. Most of the larger cloud providers will allow you to do this. Please contact us if you need assistance.

For clusters (3+ container nodes), we will also require a _Floating IP Address_. We will use arp to announce that ip on one of the 3 nodes, and handle failover automatically through corosync and pacemaker.

!!! tip ""
    If you do not want a floating IP, or are unable to allocate one, then please set `enable_floating_ip: false` and `floating_ip: ` to the IP of first node, in your `inventory.yml` file.


## Disk Setup
If you have the option to select the partition layout for the container nodes, please place most of your disk storage at `/var/lib/docker`. You can skip a dedicated `/home` partition, as this is not used in our environment.

Alternatively, create a single `/` partition with all available disk space.

??? example "Example Disk Layout"

    ```
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/sda        100G  3.5G  96GB   1% /
    /dev/sdb        1.5T   14G  1.5T   1% /var/lib/docker
    /dev/sdc        487M   94M  368M  21% /boot
    ```

## Minimum Server Requirements

Here are our minimum requirements. If you plan to have customers in your environment running production workloads, we recommend you review our [example configurations](../architecture_overview.md#example-configurations) for better guidance on what we recommend for your cluster. 

!!! tip
    All CPU Cores should be newer x86 2Ghz+ Intel or AMD processors.


Name           | CPU     | Memory | Disk
---------------|---------|--------|------
Controller     | 4 Cores | 8 GB   | 50 GB
Container Node | 4 Cores | 8 GB   | 100 GB

If you plan to use the default PowerDNS Servers, you will also need:

Name | CPU | Memory | Disk
--|--|--|--
NS1 | 1 Core | 512 MB | 15 GB
NS2 | 1 Core | 512 MB | 15 GB

## DNS Server Requirements

### AutoDNS

Our default installation is to provision two powerdns services in active passive. We also support directly integrating with AutoDNS, which would allow you to skip provisioning the two powerdns naem servers. In order to configure that, please add the following to the `controller` section of the inventory file:

```yaml
controller:
  hosts:
    # ... existing parameters ...
    dns_driver: autodns
    autodns_endpoint: "gateway.autodns.com" # https://{{ endpoint }} <-- should not be changed.
    autodns_username: ""
    autodns_password: ""
    autodns_context: "4" # The default for AutoDNS is `4`; please only change if necessary.
    autodns_nameservers: # You can omit this section if you will use the default `a/b/c/d.ns14.net` servers.
      - a.ns14.net
      - b.ns14.net
      - c.ns14.net
      - d.ns14.net
    autodns_master_ns: a.ns14.net # Generally the first in the list of nameservers.
    autodns_ns_ttl: 86400
    autodns_soa_email: 'dns@example.org'
    autodns_soa_level: 2
```

We suggest creating a dedicated AutoDNS user with limited permissions to just create and manage their own zone files, and withuot two-factor authentication. We also recommend enabling IP access restriction for that user to just the controller's public IP.

### PowerDNS

As part of the ansible installer, we will automatically provision two powerdns nameservers using Postgresql streaming replication. If you wish to use your own powerdns server, please adjust your `inventory.yml` file and add the following under the `controller` host:

```yaml
controller:
  hosts:
    # ... existing parameters ...
    pdns_skip_provisioning: true
    pdns_endpoint: "http://ns1.example.com:8081/api/v1/servers"
    pdns_api_key: "" # PowerDNS API Key
    pdns_web_key: "" # WebServer Password
    pdns_nslist:
        - "ns1.example.com"
        - "ns2.example.com"
    pdns_zone_type: Native
    pdns_masters: [] # Leave empty for Native replication
```

You would then ommit the nameserver hosts from your inventory file. It should look like this:

```yaml
primary_nameserver:
  hosts:
follower_nameservers:
  hosts:
```

??? example "Example PowerDNS Configuration File"
    ```ini
    api=yes
    api-key=CHANGEME # pwgen -s 32 1
    webserver=yes
    webserver-address=0.0.0.0
    webserver-port=8081
    webserver-allow-from=0.0.0.0/0
    webserver-password=CHANGEME # pwgen -s 32 1
    local-port=53
    local-address=0.0.0.0, ::
    include-dir=/etc/powerdns/pdns.d
    launch=gpgsql
    config-dir=/etc/powerdns
    default-soa-edit=inception-increment
    default-ttl=14400
    default-soa-content=ns1.example.com hostmaster.@ 0 10800 3600 604800 3600
    query-cache-ttl=20
    dnsupdate=yes
    allow-dnsupdate-from=
    ```


---
Next Step: [Preparing Installation Resources](1_prepare.md)
