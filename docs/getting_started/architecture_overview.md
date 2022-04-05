---
title: Architecture
description: Architecture Overview
---
# Architecture

ComputeStacks is a collection of open-source software, running in a clustered environment. This guide will walk through some of the key components to help you make an informed decision when planning your environment.

All servers will use Debian 11.

## Key Concepts

### Definitions

#### Controller
The _Controller_ is the primary ComputeStacks software. This manages the orchestration of containers onto the _Container Nodes_. 

#### Region
A _Region_ is typically a geographic location that is used to group _Availability Zones_, and their subsequent _Container Nodes_.

#### Availability Zone
An _Availability Zone (AZ)_ is a group of _Container Nodes_ within a _Region_. A single public IP will be shared by all containers running with this AZ.

#### Container Node

_Container Nodes_ are the physical compute resources that will run the containers. They are grouped by _Availability Zone_, within a single _Region_.

!!! note ""
    While the CPU on a node is shared with all containers on the node, you must have enough cores to match the maximum package size you wish to offer. For example, if you wish to sell a 4 core CPU package, then you will need at least 4 CPU Cores available on the node.

### Networking

#### Cluster Network

For [single node](#starter-environment) configurations, you only need a single public IP per server. However, in general we recommend a private network if possible.

For clustered environments, we recommend you create a dedicated private network for inter-node communication. This should not perform any kind of source/destination filtering, otherwise we will need to use an overlay network, which will reduce overall network performance.

#### Container-To-Container
Each container is given a private IP Address, and by default can only communicate with other containers in the same project. If you choose to allow external connectivity, then our load balancer will forward `80/443` to your container.

#### External Connectivity
ComputeStacks supports `http`, `tcp`, and `udp` traffic. With `http` and `tcp`, the user has the option to route the traffic through our global load balancer and enable SSL/TLS offloading. (HTTP by default will always route this way).

Our load balancer runs on each node in the availability zone, and shares a single floating IP. In the event of a node failure, we use pacemaker & corosync to move that floating IP to another node in the cluster. We maintain the same configuration on each node so that all load balancers are able to serve traffic immediately.

Depending on your goals, you may also choose to allocate public IP addresses to each container. Please contact us to discuss this in more detail.

### Container Storage

Our default configuration is to run our containers using locally-mounted storage volumes. This provides both performance, stability, and cost benefits over shared/clustered storage, and for our typical customer, provides the best fit for their business model.

However, we understand that for some deployments it makes sense to have high-availability for your container services. In those use-cases, we can use NFS storage for our container volumes, which would allow your containers to automatically failover to another node.

### Backups

ComputeStacks uses an in-house developed backup solution, built upon the excellent [borg](https://www.borgbackup.org){: target="_blank" } backup tool. We include specific backup drivers for MySQL/MariaDB and PostgreSQL that ensure consistent and unobtrusive backups. 

You will need to provide a separate backup server that will hold your customer's backups. Our installation process will automatically configure a base debian install to serve this function. We also recommend that you _do not_ share a single backup server across multiple regions.

### Container Registry

ComputeStacks offers an integrated container registry to aid in your customers image development. For small deployments, we will run this on the same server as our controller. However, we recommend that this run on it's own server.

### Metrics

As part of our normal installation process, we will configure a dedicated metrics and log aggregation server. This will collect, store, and process logs and metrics from all servers and containers in the cluster. We recommend that you install one metrics server per region. If there is too much latency between the metrics server and the container nodes, alerting and resource usage data could be delayed.

### DNS

ComputeStacks offers an optional DNS interface. You may choose to use our hosted DNS service for free, or deploy your own PowerDNS service. Our ansible installer can provision a replicated PowerDNS setup automatically.

## Example Configurations

!!! success ""
    The following configuration examples are for planning purposes only. Please work with our team to design an appropriate architecture to meet your goals.

    The recommendations below are based on a typical hosting provider's workload. This means that a majority of the containers deployed will be php-based _(e.g. wordpress)_, and use Redis & MySQL.

    _Please see our [installation guide](installation/0_requirements.md#minimum-server-requirements) for our minimum requirements._

### Single-Node Environment
For small hosting providers who are just getting started. This setup will typically support 20 Wordpress sites with average traffic.

!!! abstract "Single Region, No Cluster"

    _Container registry and metrics run on the controller._

    Server Role    | CPU     | Memory | Storage | Network Notes
    ---------------|---------|--------|---------|-------------------------
    Controller     | 4 Cores | 8 GB   | 100 GB   | Single public IP address
    Container Node | 4 Cores | 12 GB  | 150 GB  | 1 public, 1 private
    Backup Server  | 1 Core  | 1 GB   | 150 GB  | 1 public, 1 private
    PowerDNS 1     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    PowerDNS 2     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private


!!! tip "All of our cluster examples will require:"

    * A private network shared between all nodes
        * If possible, disable source/destination filtering. Otherwise you will need to use IP-in-IP.
    * **1 public floating IP _Per Availability Zone_**. If this is not possible, then disable the floating IP in the `inventory.yml` file and add the IP of the first node as the "floating ip". 
    * While the controller only needs a single public IP, we generally recommend also giving the controller access to the private network for the nodes and metrics server when possible.


### Small Cluster

!!! abstract "Single Region"
    
    _Container Registry runs on the controller_

    Server Role      | CPU     | Memory | Storage | Network Notes
    -----------------|---------|--------|---------|-------------------------
    Controller       | 4 Cores | 8 GB   | 100 GB   | Single public IP address
    Container Node 1 | 4 Cores | 12 GB  | 150 GB  | 1 public, 1 private
    Container Node 2 | 4 Cores | 12 GB  | 150 GB  | 1 public, 1 private
    Container Node 3 | 4 Cores | 12 GB  | 150 GB  | 1 public, 1 private
    Backup Server    | 1 Core  | 1 GB   | 150 GB  | 1 public, 1 private
    Metrics          | 2 Cores | 4 GB   | 50 GB   | 1 public, 1 private
    PowerDNS 1     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    PowerDNS 2     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    

### Medium Cluster

!!! abstract "Medium Cluster"

    _Container Registry runs on the controller_

    Server Role      | CPU      | Memory | Storage | Network Notes
    -----------------|----------|--------|---------|-------------------------
    Controller       | 4 Cores  | 10 GB  | 100 GB   | Single public IP address
    Container Node 1 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 2 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 3 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Backup Server    | 1 Core   | 1 GB   | 150 GB  | 1 public, 1 private
    Metrics          | 4 Cores  | 8 GB   | 50 GB   | 1 public, 1 private
    PowerDNS 1     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    PowerDNS 2     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private

### Multi-Region Cluster

!!! abstract "Shared Resources"

    Server Role        | CPU     | Memory | Storage | Network Notes
    -------------------|---------|--------|---------|-------------------------
    Controller         | 6 Cores | 12 GB  | 100 GB   | Single public IP address
    Container Registry | 2 Cores | 2 GB   | 350 GB  | Single public IP
    PowerDNS 1     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    PowerDNS 2     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private

!!! example "Region 1"

    _Private network is just for this AZ_

    Server Role      | CPU      | Memory | Storage | Network Notes
    -----------------|----------|--------|---------|-------------------------
    Container Node 1 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 2 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 3 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Backup Server    | 1 Core   | 1 GB   | 150 GB  | 1 public, 1 private
    Metrics          | 4 Cores  | 8 GB   | 50 GB   | 1 public, 1 private

!!! example "Region 2"

    _Private network is just for this AZ_

    Server Role      | CPU      | Memory | Storage | Network Notes
    -----------------|----------|--------|---------|-------------------------
    Container Node 4 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 5 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 6 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Backup Server    | 1 Core   | 1 GB   | 150 GB  | 1 public, 1 private
    Metrics          | 4 Cores  | 8 GB   | 50 GB   | 1 public, 1 private

### Single Region, Multi-AZ

!!! note ""
    You can choose to run the backup server shared between AZ's, or create a dedicated one per-AZ.
    
    _Just note that the private network must be accessible across all AZ's._

!!! abstract "Shared Resources"
    Server Role        | CPU     | Memory | Storage | Network Notes
    -------------------|---------|--------|---------|---------------------------------------------------------
    Controller         | 6 Cores | 12 GB  | 100 GB   | Single public IP address
    Container Registry | 2 Cores | 2 GB   | 350 GB  | Single public IP
    Backup Server      | 1 Core  | 1 GB   | 350 GB  | 1 public, 1 private
    Metrics            | 4 Cores | 8 GB   | 50 GB   | 1 public, 1 private
    PowerDNS 1     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private
    PowerDNS 2     | 1 Core  | 1 GB   | 20 GB   | 1 public, 1 private

!!! example "Region 1, AZ 1"
    Server Role      | CPU     | Memory | Storage | Network Notes
    -----------------|---------|--------|---------|--------------------
    Container Node 1 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 2 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 3 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
        

!!! example "Region 1, AZ 2"
    Server Role      | CPU     | Memory | Storage | Network Notes
    -----------------|---------|--------|---------|--------------------
    Container Node 4 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 5 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
    Container Node 6 | 12 Cores | 48 GB  | 150 GB  | 1 public, 1 private
