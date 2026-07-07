# Load Balancer Management

!!! note
    The load balancer can be managed in the Admin via: **Settings -> Load Balancers.**

We run HAProxy on each and every container node. For clusters, they will keep a duplicate copy of the current configuration, as well as, any certificates installed.

This way, in the event of an IP failover even, the other load balancer is already running and ready to start serving requests.

## IP Settings

| Public IP | This is the *Floating IP Address* for your cluster. If you're running a single container node, then this will be the primary IP of that node. |
| --- | --- |
| Server IPs | This is a comma separated list of IP Addresses accessible from the controller. This is how the controller will connect to the Load Balancer and install any configuration |
| Internal IPs | These are the *internal* ip addresses (also a comma separated list) of the load balancer. This will be the IP that the load balancer will connect to the container from.
If you have a separate container network attached to the node, you will enter the IP address of the node. |

## SSL Settings

You must install a Wildcard SSL certificate for the LoadBalancer. The LoadBalancer will not start without one.

During the installation process, a self-signed certificate was automatically generated and installed to the load balancer. To install a valid certificate, you have two options:

1. Purchase a wildcard certificate and install it yourself
    - *(You may optionally purchase one from us for $50/year. Please contact us for details.)*
2. Use our ACME (LetsEncrypt) service to generate a wildcard certificate for free.

In order to use our ACME wildcard generator, the domain name *must exist* in the **Settings -> DNS** menu, and the nameservers must be correctly configured.

### Example

If your shared container domain was `a.cmptstks.net`, you would create a new zone in **Settings -> DNS** for `cmptstks.net`. If your domain was `a.region.cmptstks.net`, you would still create the domain `cmptstks.net`.

Once that's added, you will now need to update the nameserver settings for your domain to point to ours. For this, you have two options:

1. Point your root domain (by editing the nameserver settings at domain registrar) to our nameservers, or;
2. Keep your existing nameserver and use delegation. This is where you create new NS records for a subdomain, and point to our nameservers. Here is an [example guide](https://support.cloudflare.com/hc/en-us/articles/360021357131-Delegating-Subdomains-Outside-of-Cloudflare) for doing that with Cloudflare.

If your loadbalancer App URL was `a.fra.example.net`, you would create the following nameserver entries to point to our hosted dns service:

```
fra.example.net 86400 IN NS ns1.auto-dns.com.
fra.example.net 86400 IN NS ns3.auto-dns.com.
fra.example.net 86400 IN NS ns3.autodns.nl.
fra.example.net 86400 IN NS ns4.autodns.nl.
```
