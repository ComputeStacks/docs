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

Each container node runs its own load balancer, which answers on that availability zone's `app_domain`. Customer containers are published as `<container>.<app_domain>`. If a node doesn't set `app_domain`, it uses `cs_app_zone`, so a single-zone installation needs exactly one pair of records.

Every availability zone needs this pair:

```text
exm-001.usercontent.example.com.     IN A       <that node's public ip>
*.exm-001.usercontent.example.com.   IN CNAME   exm-001.usercontent.example.com.
```

Every `app_domain` must be `cs_app_zone` itself or a name under it, and each availability zone needs a different one.

!!! danger "The wildcard must be a CNAME"
    The wildcard record **must be a CNAME** that points to the `app_domain` itself. A wildcard A record does not work. The controller checks for the CNAME specifically, and until it finds it, the load balancer is never marked valid and nothing can be deployed into that availability zone.

### With the bundled nameservers

With `dns_driver: powerdns`, **you don't create these records**. The delegation above is all the DNS work the customer zone needs. The installer writes each availability zone's pair into `cs_app_zone` on the primary nameserver, and the followers receive it through replication. Beside each pair it writes an ownership marker, a `_cs-lb.<app_domain>` TXT record naming the node, and every run brings the records it owns back in line with your inventory.

The installer never overwrites records it didn't write:

- If you already created a matching pair by hand, the installer adopts it.
- If anything else is at those names, such as records that differ or a marker naming another node, the run stops before it writes anything. Give the node a different `app_domain`, or, if the old records really are stale, delete them with `pdnsutil delete-rrset` and run the installer again.
- When a node's `app_domain` changes, the records for the old name are left in place and the run warns about them. Customers may still be using the old name, so removing it is up to you.

Before it builds anything, the installer checks that the parent zone delegates `cs_app_zone` to exactly your nameservers. At the end of the run, it checks the records on every nameserver and through public DNS.

!!! warning
    Don't put these records in the parent zone as well. Once `cs_app_zone` is delegated, records for names inside it that are published in the parent are never served.

The controller rewrites the whole zone when it saves DNS changes. If an administrator edit or other controller write is already in progress while the installer writes the records, the records can be lost. Running the installer again restores them.

To manage the records yourself instead, set `powerdns_manage_lb_records: false` on the primary nameserver in your inventory. You then create them as described below.

### With any other DNS

With `dns_driver: none`, or with `powerdns_manage_lb_records: false`, **you create the pair for every availability zone yourself. This is the step most often missed.** Create the records before the run, in the public DNS that serves each `app_domain`. The installer checks both records from your control machine before it builds anything. It also confirms them at the end of the run, once the controller has validated each load balancer.

### Delegating each availability zone separately

The layout above delegates the whole of `cs_app_zone` to your nameservers. If you delegate each `app_domain` separately instead, for example because you can't hand over the parent domain, create a matching zone for each one on the bundled primary nameserver:

```bash
pdnsutil create-zone exm-001.usercontent.example.com ns1.example.com
```

Without it, some resolvers reject the nameservers' answers for record types that don't exist at the zone apex, which shows up as intermittent lookup failures on container hostnames rather than an outage.

The installer doesn't manage load balancer records in a zone like this. It skips that availability zone with a warning, so create the pair in that zone yourself. The checks at the end of the run still confirm what the nameservers serve.

## Without the bundled nameservers

To manage DNS without the bundled nameservers, leave the `nameservers` group out of your inventory and set `dns_driver: none`. The installer then doesn't install PowerDNS or configure DNS in the controller. You still need the platform server records, and you create the [load balancer records](#with-any-other-dns) yourself. You can configure a DNS driver in the controller's admin area afterward.

## Next steps

Continue to [Install ComputeStacks](install.md).
