# Architecture Overview

ComputeStacks is a collection of open-source software that runs across a small cluster of servers. This page describes each component, how they fit together, and the vocabulary the installer uses, so you can plan your environment before you install it.

Every server runs **Ubuntu 26.04 LTS** (amd64). The whole environment is installed and maintained by the [ComputeStacks provisioner](https://github.com/ComputeStacks/ansible-install), a set of Ansible playbooks you run from your own workstation.

## Components

A complete environment has six server roles. Each one is an Ansible inventory group.

| Role | What it runs | How many |
| --- | --- | --- |
| **Controller** | The ComputeStacks portal and API, PostgreSQL, Redis, Vault (the internal certificate authority for Docker), and nginx with automatic TLS certificates. | Exactly one. |
| **Metrics** | Prometheus, Alertmanager, and Loki, behind nginx with TLS and basic auth. | One per site. |
| **Backup** | A [borg](https://www.borgbackup.org/) backup server that holds your customers' volume backups. | Zero or one per site. |
| **Registry** | The host the controller creates your customers' private container registries on. | Zero or one. |
| **Nameservers** | PowerDNS, with a primary and any number of replicated followers. | One primary and zero or more followers, or none if you manage DNS elsewhere. |
| **Container nodes** | Docker, the ComputeStacks agent, the HAProxy load balancer, and the metrics and log shippers. | One per availability zone. |

The smallest sensible installation is **five servers plus one container node**: a controller, a metrics server, a backup server, a registry, a nameserver, and a node.

### Controller

The *controller* is the primary ComputeStacks software. It hosts the web portal and API, and it orchestrates containers onto the container nodes. It talks to each node's Docker engine over mutual TLS and to each node's agent over HTTP.

### Container nodes

*Container nodes* are the compute resources that run your customers' containers. Each node also runs its own HAProxy load balancer, which the controller configures. Traffic for a customer's container arrives at the node that hosts it.

!!! note
    While the CPU on a node is shared by all of its containers, you must have enough cores to match the largest package you want to offer. For example, to sell a 4-core package, the node needs at least 4 CPU cores.

### Metrics

The metrics server collects, stores, and processes metrics and logs from every server and container in its site. The controller also queries it when placing new containers. If there is too much latency between the metrics server and the nodes, alerting and resource-usage data can be delayed, which is why each site has its own.

### Backups

ComputeStacks has its own backup system, built on [borg](https://www.borgbackup.org/), with specific integrations for MySQL/MariaDB and PostgreSQL that take consistent, unobtrusive backups. The agent on each node sends customer volume backups to its site's backup server. A site with no backup server installs its nodes with backups disabled.

!!! warning
    The backup server holds *customer* data only. The controller's own database is not backed up automatically. See [After installation](after-installation.md#back-up-the-controller-database).

### Container registry

ComputeStacks includes an integrated container registry to help your customers build and ship their own images. The controller creates each customer registry on the registry host over SSH.

### DNS

ComputeStacks includes a DNS manager with a PowerDNS integration. It lets your customers host DNS zones with you, and it provides the records needed to issue certificates for the containers behind your load balancers. The provisioner can install a replicated PowerDNS cluster for you. If you manage DNS some other way, you can skip the nameservers.

## Vocabulary

The provisioner and the controller use slightly different names for the same things.

| In the inventory | In the controller | Meaning |
| --- | --- | --- |
| `region` | Location | A geographic location, for example `ams1`. |
| `az` | Region | An availability zone inside a location. Each one has exactly one container node. |
| `site` | *(none)* | The physical facility a server lives in. It decides which metrics server and backup server a node uses. |
| `cs_app_zone` | DNS zone | The single parent domain that all customer container hostnames live under. |
| `app_domain` | Load balancer domain | The domain a single availability zone's load balancer answers on. Defaults to `cs_app_zone`. |

!!! tip
    Earlier versions of ComputeStacks supported several nodes in one availability zone. From v9 forward, each availability zone has exactly one node.

### Sites

A *site* exists only in the provisioner and is never stored in the controller. Two locations can share one facility, so the site, not the location, decides which metrics server scrapes a node and which backup server it writes to. A location never spans sites.

**A single-site installation doesn't need to set `site` anywhere.** Every server then falls into a site called `default`.

## Key concepts

### Networking

Each server has a private address (`primary_ip`) that the control plane uses and a public address (`public_ip`). They may be the same address. We recommend a private network between the controller and the other servers.

For regions that don't share a private network with the controller, the provisioner can join every server to a [Tailscale](https://tailscale.com) network. The controller then reaches each node's agent, and Prometheus scrapes each node, over that encrypted network instead of the public internet.

The provisioner manages each server's firewall itself, using nftables.

### Container-to-container

Each container gets a private IP address. By default, it can only communicate with other containers in the same project.

### External connectivity

ComputeStacks supports `http`, `tcp`, and `udp` traffic. With `http` and `tcp`, the user can route traffic through the node's load balancer and enable TLS offloading. HTTP always routes this way. Container nodes accept customer traffic on ports 80 and 443, and on ports 10000–50000 for TCP and UDP services.

### Container storage

By default, containers use locally mounted storage volumes. This gives better performance, stability, and cost than shared or clustered storage, and is the best fit for most hosting providers.

## Example configurations

!!! tip
    These examples are for planning only. They assume a typical hosting workload, where most containers are PHP-based (for example, WordPress) and use Redis and MySQL.

We recommend running each role on its own server.

### Minimum environment

| Server role | CPU | Memory | Storage |
| --- | --- | --- | --- |
| Controller | 4 cores | 8 GB | 100 GB |
| Container node | 4 cores | 12 GB | 150 GB |
| Metrics | 2 cores | 4 GB | 50 GB |
| Backup | 1 core | 1 GB | 150 GB |
| Registry | 2 cores | 4 GB | 100 GB |
| Nameserver | 1 core | 1 GB | 20 GB |

### Typical production, single region

| Server role | CPU | Memory | Storage |
| --- | --- | --- | --- |
| Controller | 4 cores | 12 GB | 100 GB |
| Container node | 12 cores | 48 GB | 350 GB |
| Registry | 4 cores | 12 GB | 300 GB |
| Metrics | 4 cores | 8 GB | 100 GB |
| Backup | 1 core | 1 GB | 300 GB |
| Nameserver 1 | 1 core | 1 GB | 20 GB |
| Nameserver 2 | 1 core | 1 GB | 20 GB |

### Multi-region

Shared by every region:

| Server role | CPU | Memory | Storage |
| --- | --- | --- | --- |
| Controller | 4 cores | 12 GB | 100 GB |
| Registry | 4 cores | 12 GB | 300 GB |
| Nameserver 1 | 1 core | 1 GB | 20 GB |
| Nameserver 2 | 1 core | 1 GB | 20 GB |

For each site:

| Server role | CPU | Memory | Storage |
| --- | --- | --- | --- |
| Container node (one per availability zone) | 12 cores | 48 GB | 350 GB |
| Metrics | 4 cores | 8 GB | 100 GB |
| Backup | 1 core | 1 GB | 300 GB |

## Next steps

Continue to [Requirements](requirements.md).
