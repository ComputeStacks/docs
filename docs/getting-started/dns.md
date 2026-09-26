# Prepare DNS

Create your DNS records **before** you run the installer. TLS certificates are issued during the run, so every name must already resolve. Create them early, too: a resolver that looked up a name before it existed can cache the "not found" answer for a while.

The examples on this page use these names. Substitute your own.

| Purpose | Inventory setting | Example |
| --- | --- | --- |
| Portal and API | `cs_portal_domain` | `portal.example.com` |
| Metrics | `cs_metrics_domain` | `metrics.example.com` |
| Container registry | `cs_registry_domain` | `cr.example.com` |
| Customer containers | `cs_app_zone` | `usercontent.example.com` |
| Nameservers | `powerdns_name` | `ns1.example.com`, `ns2.example.com` |

All of these records go in your **public** DNS, at the provider that hosts `example.com`.

## Platform servers

Point the portal, metrics, and registry names at their servers' public addresses:

```text
portal.example.com.    IN A   <controller public ip>
metrics.example.com.   IN A   <metrics public ip>
cr.example.com.        IN A   <registry public ip>
```

If you have more than one site, each additional metrics server needs its own name, set with `metrics_domain` on that server in the inventory:

```text
metrics.west.example.com.   IN A   <second site's metrics public ip>
```

## Delegate the customer zone

If you're installing the bundled nameservers, delegate `cs_app_zone` to them, with glue records for the nameservers themselves:

```text
usercontent.example.com.   IN NS   ns1.example.com.
usercontent.example.com.   IN NS   ns2.example.com.
ns1.example.com.           IN A    <ns1 public ip>
ns2.example.com.           IN A    <ns2 public ip>
```

`cs_app_zone` must be between two and five labels long. `usercontent.example.com` is three.

## Load balancer records

**You need one pair of records for every availability zone. This is the step most often missed.**

Each container node runs its own load balancer, which answers on that availability zone's `app_domain`. Customer containers are published as `<container>.<app_domain>`. If a node doesn't set `app_domain`, it uses `cs_app_zone`, so a single-zone installation needs exactly one pair.

For each availability zone:

```text
exm-001.usercontent.example.com.     IN A       <that node's public ip>
*.exm-001.usercontent.example.com.   IN CNAME   exm-001.usercontent.example.com.
```

!!! danger "The wildcard must be a CNAME"
    The wildcard record **must be a CNAME** that points to the `app_domain` itself. A wildcard A record does not work. The controller checks for the CNAME specifically, and until it finds it, the load balancer is never marked valid and nothing can be deployed into that availability zone.

Put these records in the public DNS that delegates to your nameservers, not in the customer zone the nameservers host. Every `app_domain` must be `cs_app_zone` itself or a name under it, and each availability zone needs a different one.

The installer checks both records from your control machine before it builds anything. It also confirms them at the end of the run, once the controller has validated each load balancer.

### Delegating each availability zone separately

The layout above delegates the whole of `cs_app_zone` to your nameservers. If you delegate each `app_domain` separately instead, for example because you can't hand over the parent domain, create a matching zone for each one on the bundled primary nameserver:

```bash
pdnsutil create-zone exm-001.usercontent.example.com ns1.example.com
```

Without it, some resolvers reject the nameservers' answers for record types that don't exist at the zone apex, which shows up as intermittent lookup failures on container hostnames rather than an outage.

## Without the bundled nameservers

To manage DNS without the bundled nameservers, leave the `nameservers` group out of your inventory and set `dns_driver: none`. The installer then doesn't install PowerDNS or configure DNS in the controller. You still need the platform server records and the load balancer records above. You can configure a DNS driver in the controller's admin area afterward.

## Next steps

Continue to [Install ComputeStacks](install.md).
