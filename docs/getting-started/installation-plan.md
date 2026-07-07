# Installation: Plan

!!! note
    Before proceeding, we recommend you first review our [Architecture Overview](architecture-overview.md).

Our installation process requires [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) to be installed either locally on your computer, or remotely on a linux machine. Please ensure this has been setup prior to continuing with this installation process.

## Linux Distribution

We currently only support **Debian 12 Bookworm**.

## Domain Names

Various services require a proper dns configuration. Please ensure the following domains are configured and ready prior to installation.

### Controller

This is the main URL for the control panel. 

Example: ***portal, dashboard, controller.***

### Metrics

The metrics server will collect container and node metrics, as well as serve as the log aggregation platform for containers. The controller and all nodes in the availability zone *(or region depending on configuration)* will need to connect to this via SSL. Ensure you have a valid DNS configured; the ansible installer will automatically generate a lets encrypt ssl certificate. 

Recommended Format: ***metrics.`<availability-zone>`.`<region>`.example.net***

Example: ***metrics.a.ams.example.net***

### Default Application URL

Each container service will receive a default URL. You will need to define a unique base domain for *each* node. For example, for node `a` in region `ams`:

Example: ***a.ams.example.net***

### PowerDNS

You will need to configure domain names used by both power dns servers (primary, and follower).

Example: ***ns1.example.net,*** and ***ns2.example.net***

### Example Zone file

```
a.dev.cmptstks.net. IN A %{node_ip}
metrics.dev.cmptstks.net. IN A %{PUBLIC IP OF METRICS SERVER}
*.a.dev.cmptstks.net. IN CNAME a.dev.cmptstks.net.
portal.dev.cmptstks.net. IN A %{controller ip address}
cr.dev.cmptstks.net. IN CNAME portal.dev.cmptstks.net.
```

## Linux User Setup

Our container nodes depend on having UID & GID `1001` available for our use. This is generally not a problem on most cloud and virtual machine images, however if you performed some pre-installation steps that included creating a user, this UID/GID may be already taken.

Please change the UID and GID of the user who took that ID before proceeding. [Here is a guide](https://kerneltalks.com/tips-tricks/how-to-change-uid-or-gid-safely-in-linux/) to help you accomplish this.

You can verify that this is available by running the following commands on the container nodes.

```bash
cat /etc/passwd | grep 1001
cat /etc/group | grep 1001
```

## Network Setup

Our recommended ip setup is: 1 Public, 1 Private, per server. You can configure the private IPs of the nodes to communicate over that private IP if the controller is within the same network. Otherwise, the controller may communicate with the nodes over their public IP Address.

## Disk Setup

If you have the option to select the partition layout for the container nodes, please place most of your disk storage at `/var/lib/docker`. You can skip a dedicated `/home` partition, as this is not used in our environment.

Alternatively, create a single `/` partition with all available disk space.

```
# Example Disk Layout
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda        100G  3.5G  96GB   1% /
/dev/sdb        1.5T   14G  1.5T   1% /var/lib/docker
/dev/sdc        487M   94M  368M  21% /boot
```

## Minimum Server Requirements

Here are our minimum requirements. If you plan to have customers in your environment running production workloads, we recommend you review our [example configurations](architecture-overview.md#example-configurations) for better guidance on what we recommend for your cluster.

| Name | CPU | Memory | Disk |
| --- | --- | --- | --- |
| Controller | 4 Cores | 8 GB | 50 GB |
| Container Node | 4 Cores | 8 GB | 100 GB |

PowerDNS:

| Name | CPU | Memory | Disk |
| --- | --- | --- | --- |
| NS1 | 1 Core | 512 MB | 15 GB |
| NS2 | 1 Core | 512 MB | 15 GB |

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

We suggest creating a dedicated AutoDNS user with limited permissions to just create and manage their own zone files, and without two-factor authentication. We also recommend enabling IP access restriction for that user to just the controller's public IP.

### PowerDNS

As part of the ansible installer, we will automatically provision two powerdns nameservers using PostgreSQL streaming replication. If you wish to use your own powerdns server, please adjust your `inventory.yml` file and add the following under the `controller` host:

```yaml
controller:
  hosts:
    # ... existing parameters ...
    pdns_skip_provisioning: true
    pdns_endpoint: "<http://ns1.example.com:8081/api/v1/servers>"
    pdns_api_key: "" # PowerDNS API Key
    pdns_web_key: "" # WebServer Password
    pdns_nslist:
        - "ns1.example.com"
        - "ns2.example.com"
    pdns_zone_type: Native
    pdns_masters: [] # Leave empty for Native replication
```

You would then omit the name server hosts from your inventory file. It should look like this:

```yaml
primary_nameserver:
  hosts:
follower_nameservers:
  hosts:
```

```
# Example PowerDNS Configuration File
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

**Next Step:** [Prepare Installation](installation-prepare.md)
