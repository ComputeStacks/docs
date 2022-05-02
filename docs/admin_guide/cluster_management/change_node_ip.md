---
title: Change Node IP
description: How to change the IP of a node.
---
# How to change the IP of a node

Various services on the node require certificate authentication. As part of that process, we use the ip address of the server in the certificate -- this must match the ip that the server will be connecting from. When changing that IP, you must generate new certificates.

In this example, we will use the following:

* NEW IPs for our server: `8.8.8.8`, and a private ip of: `10.0.0.2`
* The OLD IPs were: `1.1.1.1`, and a private IP of: `10.10.0.20`
* The hostname is node101

!!! danger ""
    In most configurations, consul is bound to the _public ip_, and etcd is bound to the _private ip_. Your configuration may be different, so please double check the current configuration to find the correct IP before proceeding.

## Process Overview

The steps we will take to update the node IP Address will involve the following:

1. Generating new certificates using vault
2. Updating configuration files on the node for all related services
3. Updating iptable rules on all servers in your environment
4. Updating the configuration in ComputeStacks
5. Testing configuration.

Prior to proceeding with this, first make sure that connectivity works between all servers that will be required to communicate with each other, and that relevant SSH keys exist (this should have already been taken care of by our installer).

## Generate New Certificates

### Unseal Vault

Before continuing, navigate back to your ansible project that you used to create your cluster, and run the following command to unseal vault on the controller.

```
ansible-playbook -u root -i inventory.yml main.yml --tags "vault_unseal"
```

!!! tip ""
    If you have multiple availability zones, and therefore multiple inventory files, just pick any of them. Vault runs on the controller, so therefore all inventory files will work.

### etcd
```
docker exec -it vault-bootstrap vault write pki/etcd/issue/server \
                                                common_name=node101 \
                                                ip_sans="127.0.0.1,8.8.8.8,10.0.0.2" \
                                                ttl=43800h
```

Replace the contents of `/etc/etcd/certs/server/server.key` and `/etc/etcd/certs/server/server.crt` respectively. 

note: you will need to `chmod +w` and `chmod -w` the file before, and after, updating ALL the files in this process.

With the certificates updated, now change the IP Address.

??? example "Multiple nodes"
    ```bash
    # on the node being changed, stop etcd
    systemctl stop etcd
    
    # Get the member id (from another node)
    etcdctl member list
    
    # update with (where 3f0a39ffd865c7a6 is the member id found in the previous command)
    etcdctl member update 3f0a39ffd865c7a6 --peer-urls=https://10.0.0.2:2380
    sed -i 's/10.10.0.20/10.0.0.2/g' /etc/etcd/etcd.conf    
    ```
??? example "Single Node"
    ```bash
    systemctl stop etcd
    sed -i 's/10.10.0.20/10.0.0.2/g' /etc/etcd/etcd.conf
    ```
    
Back on the node you're modifying:
```bash
sed -i 's/10.10.0.20/10.0.0.2/g' /etc/profile.d/etcdctl.sh && source /etc/profile.d/etcdctl.sh
systemctl start etcd
```


!!! danger ""
    Ensure etcd is working before proceeding by running `etcdctl member list`.

### Calico Network

Next step is to update the etcd configuration for calico, our network management tool. Please use this snippet, just replace your IPs:

```bash
sed -i 's/10.10.0.20/10.0.0.2/g' /etc/calico/calicoctl.cfg && sed -i 's/10.10.0.20/10.0.0.2/g' /etc/calico/calico-ipam.env && sed -i 's/10.10.0.20/10.0.0.2/g' /usr/local/bin/run_calico && systemctl restart calico-ipam && docker stop calico-node && docker rm calico-node && /usr/local/bin/run_calico
```

### Consul

!!! abstract "consul certificates"    
    ```bash
    docker exec -it vault-bootstrap vault write pki/consul/issue/server \
                                                common_name=node101 \
                                                alt_names=localhost \
                                                ip_sans="127.0.0.1,8.8.8.8,10.0.0.2" \
                                                ttl=43800h
    ```

Update the certificate files under `/etc/consul/ssl` and `/etc/computestacks/certs/consul/.

You will also need to update the systemd file to ensure administrative consul cli commands still function. Here is a complete command to perform that, and restart consul:

```bash
sed -i 's/1.1.1.1/8.8.8.8/g' /etc/systemd/system/consul.service && systemctl daemon-reload && systemctl restart consul
```

You will also need to update our agent configuration file. Here is a one-liner, just replace the IPs:

```bash
chmod +w /etc/computestacks/agent.yml && sed -i 's/1.1.1.1/8.8.8.8/g' /etc/computestacks/agent.yml && chmod -w /etc/computestacks/agent.yml && systemctl restart cs-agent
```

### docker

!!! abstract "docker certificates"  
    ```bash
    docker exec -it vault-bootstrap vault write pki/docker/issue/server \
                                                    common_name=node101 \
                                                    alt_names=localhost \
                                                    ip_sans="127.0.0.1,8.8.8.8,10.0.0.2" \
                                                    ttl=43800h
    ```

Update the certificate files under `/etc/docker/certs` and `/etc/computestacks/certs/docker`.

Update the docker etcd configuration with this snippet:

```bash
sed -i 's/10.10.0.20/10.0.0.2/g' /etc/systemd/system/docker.service.d/startup.conf && systemctl daemon-reload && systemctl restart docker
```

## IPTables

You will now need to ensure that all the iptables are updated. You may find our persistence file here: `/usr/local/bin/cs-recover_iptables`. Please update all relevant IP Addresses. _This needs to be done on ALL your servers_.

Once you've done that, _manually_ run the individual lines _(don't re-run the entire file!)_.

For example, run this on each server to delete the old rule and add the new rule:

```
iptables -D INPUT -p all -s 1.1.1.1 -j ACCEPT
iptables -A INPUT -p all -s 8.8.8.8 -j ACCEPT
```

## Backups

In addition to the iptable rules, you will also need to update the nfs exports list on the backup server. Here is a one-line example:

```bash
sed -i 's/10.10.0.20/10.0.0.2/g' /etc/exports && exportfs -ra
```

This will modfy the exports file on the backup server, and reload the nfs server.

## Update ComputeStacks

In the ComputeStacks administrator, perform the following steps:

1. Change the Node IP: `Admin -> Regions -> (Manage) -> Edit the node`.

2. Change the LoadBalancer IPs: `Admin -> Load Balancers -> Edit`.

## Conclusion

Once that has all been completed, you may edit the node in the ComputeStacks admin and run `cstacks test` on the controller to ensure connectivity.

Please perform a sample deployment to ensure everything functions correctly.
