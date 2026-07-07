# Architecture Overview

ComputeStacks is a collection of open-source software, running in a clustered environment. This guide will walk through some of the key components to help you make an informed decision when planning your environment.

All servers will use Debian 12.

## Definitions

### Controller

The *Controller* is the primary ComputeStacks software. This manages the orchestration of containers onto the *Container Nodes*.

### Region

A *Region* is typically a geographic location that is used to group *Availability Zones*.

### Availability Zone

An *Availability Zone* is a unit of resources within the same region that is used to group *Container Nodes*.

!!! tip
    This is a holdover from previous version of ComputeStacks that supported multiple clustered nodes within an availability zone. From v9 forward, all *Availability Zones* will only ever have 1 node.

### Container Node

*Container Nodes* are the physical compute resources that will run the containers. 

!!! note
    While the CPU on a node is shared with all containers on the node, you must have enough cores to match the maximum package size you wish to offer. 
    For example, if you wish to sell a 4 core CPU package, then you will need at least 4 CPU Cores available on the node.

## Key Concepts

### Networking

### Container-To-Container

Each container is given a private IP Address, and by default can only communicate with other containers in the same project. If you choose to allow external connectivity, then our load balancer will forward `80/443` to your container.

### External Connectivity

ComputeStacks supports `http`, `tcp`, and `udp` traffic. With `http` and `tcp`, the user has the option to route the traffic through our global load balancer and enable SSL/TLS offloading. (HTTP by default will always route this way).

Our load balancer runs on the container nodes.

### Container Storage

Our default configuration is to run our containers using locally-mounted storage volumes. This provides both performance, stability, and cost benefits over shared/clustered storage, and for our typical customer, provides the best fit for their business model.

### Backups

ComputeStacks uses an in-house developed backup solution, built upon the excellent [borg](https://www.borgbackup.org/) backup tool. We include specific backup integrations for MySQL/MariaDB and PostgreSQL that ensure consistent and unobtrusive backups.

You will need to provide a separate backup server that will hold your customer’s backups. Our installation process will automatically configure a base debian install to serve this function. We also recommend that you *do not* share a single backup server across multiple regions.

### Container Registry

ComputeStacks offers an integrated container registry to aid in your customers image development. For small deployments, we will run this on the same server as our controller. However, we recommend that this run on it’s own server.

### Metrics

As part of our normal installation process, we will configure a dedicated metrics and log aggregation server. This will collect, store, and process logs and metrics from all servers and containers in the cluster. We recommend that you install one metrics server per region. If there is too much latency between the metrics server and the container nodes, alerting and resource usage data could be delayed.

### DNS

ComputeStacks includes a DNS manager and integration to PowerDNS. This is used for both allowing your customers to host dns ones with you, while also providing support for generating wildcard SSL certificates for your load balancer. Our ansible installer can provision a replicated PowerDNS setup automatically.

---

## Example Configurations

!!! tip
    The following configuration examples are for planning purposes only. Please work with our team to design an appropriate architecture to meet your goals.

    The recommendations below are based on a typical hosting provider's workload. This means that a majority of the containers deployed will be php-based *(e.g. wordpress)*, and use Redis & MySQL.

!!! note
    Please see our [installation guide](installation-plan.md) for our minimum requirements.

*We recommend that the controller communicates with the other nodes over a private network.*

### Minimum Requirements

```markdown
Container registry and metrics run on the controller.

Server Role    | CPU     | Memory | Storage
---------------|---------|--------|---------
Controller     | 4 Cores | 8 GB   | 100 GB
Container Node | 4 Cores | 12 GB  | 150 GB
Backup Server  | 1 Core  | 1 GB   | 150 GB
PowerDNS 1     | 1 Core  | 1 GB   | 20 GB
PowerDNS 2     | 1 Core  | 1 GB   | 20 GB
```

### Recommended Minimum Environment

```markdown
Container Registry runs on the controller

Server Role      | CPU     | Memory | Storage
-----------------|---------|--------|--------
Controller       | 4 Cores | 8 GB   | 100 GB
Container Node   | 4 Cores | 12 GB  | 150 GB
Backup Server    | 1 Core  | 1 GB   | 150 GB
Metrics          | 2 Cores | 4 GB   | 50 GB
PowerDNS 1       | 1 Core  | 1 GB   | 20 GB
PowerDNS 2       | 1 Core  | 1 GB   | 20 GB
```

### Typical Production Single Region

```markdown
Server Role        | CPU      | Memory | Storage
-------------------|----------|--------|--------
Controller         | 4 Cores  | 12 GB  | 100 GB
Container Node     | 12 Cores | 48 GB  | 350 GB
Container Registry | 4 Cores  | 12 GB  | 300 GB
Backup Server      | 1 Core   | 1 GB   | 300 GB
Metrics            | 4 Cores  | 8 GB   | 100 GB
PowerDNS 1         | 1 Core   | 1 GB   | 20 GB
PowerDNS 2         | 1 Core   | 1 GB   | 20 GB
```

### Multi-Region Example

```markdown
# Shared Resources

Server Role        | CPU      | Memory | Storage
-------------------|----------|--------|--------
Controller         | 4 Cores  | 12 GB  | 100 GB
Container Registry | 4 Cores  | 12 GB  | 300 GB
PowerDNS 1         | 1 Core   | 1 GB   | 20 GB
PowerDNS 2         | 1 Core   | 1 GB   | 20 GB

# Region 1

Server Role        | CPU      | Memory | Storage
-------------------|----------|--------|--------
Container Node     | 12 Cores | 48 GB  | 350 GB
Backup Server      | 1 Core   | 1 GB   | 300 GB
Metrics            | 4 Cores  | 8 GB   | 100 GB

# Region 2

Server Role        | CPU      | Memory | Storage
-------------------|----------|--------|--------
Container Node     | 12 Cores | 48 GB  | 350 GB
Backup Server      | 1 Core   | 1 GB   | 300 GB
Metrics            | 4 Cores  | 8 GB   | 100 GB

```
