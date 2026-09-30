# Troubleshooting

## Re-running the installer

The installer is safe to re-run. Each run brings every server back in line with your inventory, so after fixing a problem, run it again. A run can reboot servers with pending updates; see [Automatic reboots](install.md#automatic-reboots).

The controller's database is the exception. The installer creates locations, availability zones, nodes, load balancers, and settings only when they are missing, and never overwrites them. If your inventory disagrees with what's already in the controller, the run reports the difference instead of applying it. Change those settings in the controller's admin area.

## Preflight failures

Preflight runs first and changes nothing. Its message tells you what to fix. The most common causes are:

**The server isn't Ubuntu 26.04 on amd64.**
: Reinstall the server with Ubuntu 26.04 LTS.

**Ansible isn't connecting as root.**
: Set `ansible_user: root` in `group_vars/all/main.yml`. On Ubuntu cloud images, also add `disable_root: false` to the cloud-init user data.

**The hostname isn't valid.**
: `hostname` in the inventory must be a single lowercase word: letters, digits, and hyphens, starting with a letter. Set the same name on the server with `hostnamectl set-hostname`.

**`secret_key_base` or `user_auth_secret` is missing or too short.**
: Generate each with `openssl rand -hex 64`.

**The customer zone isn't delegated to your nameservers.**
: With `dns_driver: powerdns`, the parent zone must delegate `cs_app_zone` to exactly the `powerdns_name` of every nameserver in your inventory. The message lists the NS records to create. See [Delegate the customer zone](dns.md#delegate-the-customer-zone).

**Load balancer DNS records are missing or wrong.**
: If you manage the load balancer records yourself, each availability zone needs an A record for its `app_domain` and a wildcard **CNAME** pointing to it. See [Load balancer records](dns.md#load-balancer-records).

If your control machine can't see public DNS, for example with split-horizon DNS, set `preflight_check_app_domain_dns: false` to skip both DNS checks.

**Existing load balancer records conflict.**
: With the bundled nameservers, the run stops before writing anything if an `app_domain` already holds records the installer didn't write. Choose a different `app_domain`, or delete the stale records with `pdnsutil delete-rrset` and run again. See [With the bundled nameservers](dns.md#with-the-bundled-nameservers).

## Load balancer domain not valid

If the `lb_domain` check fails, or the controller shows an event saying a load balancer's domain is invalid, check the availability zone's DNS records:

| Event code | Meaning |
| --- | --- |
| `2721edc59787a807` | The wildcard CNAME record is missing. A wildcard A record causes this too. |
| `635285f7f2889009` | The wildcard CNAME points somewhere other than the `app_domain`. |
| `510806d5621c97d5` | The `app_domain` A record isn't the load balancer's public address. |

Until the domain is valid, nothing can be deployed into that availability zone.

## A node fails to enroll

If a node fails at the enrollment step, the `hostname` in the inventory most likely differs from the node's actual hostname. Correct it and re-run the installer. To re-enroll a single node:

```bash
make site ENV=prod LIMIT=node1001 ARGS='--tags enroll'
```

## A controller seeding failure

If seeding the controller fails, the configuration it tried to apply is kept at `/var/lib/computestacks/manifest.yml` on the controller for you to inspect. It's removed after a successful run.

## Vault is sealed after a reboot

The controller's Vault seals itself when the controller restarts. Any run of the installer unseals it. To unseal it without a full run:

```bash
ansible-playbook -i inventories/prod playbooks/unseal.yml --ask-vault-pass
```

## Certificate rate limits

Production Let's Encrypt issues only five duplicate certificates per week for the same names. If you rebuild an environment often, use `acme_ca: letsencrypt_test`. When switching certificate authorities on an existing installation, add `-e acme_web_force_issue=true` to the next run so the certificates are reissued.

## Nodes with IPv6 lose connectivity

If a node with a public IPv6 address loses its default route about 30 minutes after installation, set `uplink_interface` on that node to its network interface name and re-run the installer.

## Remote nodes can't reach the controller

If the `acme_backend` check fails on a node in a remote region, the node can't reach the controller's private address. Either join both to Tailscale, or set `controller_acme_address` on the node to a controller address it can reach.

If the availability zone already exists in the controller, changing either of these doesn't update the address the controller has stored. Once the new path works, apply it with a full run:

```bash
make site ENV=prod ARGS='-e controller_seed_update_addresses=true'
```

The run shows the address changes and pauses for you to confirm them.

## Where to find logs

| What | Where |
| --- | --- |
| Controller | `cstacks logs` or `cstacks tail-logs` on the controller. |
| Other services | The systemd journal on each server, for example `journalctl -u cs-agent` on a node. |
| Customer container logs | Loki, on the metrics server for that site. |

## Starting over

The provisioner doesn't include an uninstall. To remove an environment, destroy the servers, then remove the DNS records you created and, if you used Tailscale, the servers' devices from your tailnet.
