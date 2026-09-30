# Install ComputeStacks

This page walks through a new installation from bare Ubuntu 26.04 servers. It assumes you've met the [requirements](requirements.md) and created your [DNS records](dns.md).

To add a region to an environment that already exists, see [Add regions and nodes](adding-regions.md) instead.

## 1. Get the provisioner

On your control machine:

```bash
git clone https://github.com/ComputeStacks/ansible-install computestacks
cd computestacks
make deps
```

`make deps` installs the pinned Ansible roles and collections into the project directory. If you'd rather not use `make`, run the two commands it wraps:

```bash
ansible-galaxy role install -r requirements.yml -p galaxy_roles
ansible-galaxy collection install -r requirements.yml -p collections
```

## 2. Create your inventory

One inventory describes your whole installation: every server, every region. Start from the example:

```bash
cp -r inventories/example inventories/prod
```

It contains four files:

| File | Contents |
| --- | --- |
| `hosts.yml` | Your servers, grouped by role, and the settings for each one. |
| `group_vars/all/main.yml` | Environment-wide settings: domains, admin email, locale, DNS, and certificates. |
| `group_vars/all/secrets.yml` | Passwords and keys. You encrypt this file. |
| `zz_constructed.yml` | Builds `region_*` and `az_*` groups automatically. Leave it as is. |

!!! warning
    Keep the `zz_` prefix on `zz_constructed.yml`. Ansible reads the files in alphabetical order, and this one has to come after `hosts.yml`.

The example describes two sites and three regions. Remove what you don't need.

### Servers

Edit `inventories/prod/hosts.yml`. Every server needs:

| Setting | Description |
| --- | --- |
| `ansible_host` | The address Ansible connects to. |
| `hostname` | The server's single-word hostname. It must match the name set on the server. |
| `primary_ip` | The private address the control plane uses. |
| `public_ip` | The public address. It can be the same as `primary_ip`. |

Each **container node** also needs:

| Setting | Description |
| --- | --- |
| `region` | The location this node belongs to, for example `exm001`. It becomes a Location in the controller. |
| `az` | The availability zone, for example `exm-001`. It becomes a Region in the controller. Each `az` has exactly one node. |
| `container_network` | The node's private container network, for example `10.100.4.0/22`. |
| `container_network_name` | A name for that network, for example `net-exm-001`. |
| `app_domain` | *Optional.* The domain this availability zone's load balancer answers on. Defaults to `cs_app_zone`. |
| `site` | *Optional.* The site this node belongs to. Leave it unset for a single-site installation. |
| `uplink_interface` | *Required on nodes with a public IPv6 address.* The name of the network interface that carries the default route, for example `eth0`. Without it, the node loses its IPv6 default route about 30 minutes after the first IPv6 container network is created. |

Each **nameserver** needs `powerdns_name`, its unique, fully qualified name, for example `ns1.example.com`. These names become the customer zone's NS records.

On a multi-site installation, set `site` on each node, metrics server, and backup server. Don't set it on the controller, registry, or nameservers; they serve every site.

Here is a minimal single-site `hosts.yml`:

```yaml
all:
  children:
    controller:
      hosts:
        ctl1:
          ansible_host: 192.0.2.10
          hostname: ctl1
          primary_ip: 10.100.0.10
          public_ip: 192.0.2.10
    metrics:
      hosts:
        metrics1:
          ansible_host: 192.0.2.11
          hostname: metrics1
          primary_ip: 10.100.0.11
          public_ip: 192.0.2.11
    backup:
      hosts:
        backup1:
          ansible_host: 192.0.2.12
          hostname: backup1
          primary_ip: 10.100.0.12
          public_ip: 192.0.2.12
    registry:
      hosts:
        registry1:
          ansible_host: 192.0.2.13
          hostname: registry1
          primary_ip: 10.100.0.13
          public_ip: 192.0.2.13
    nameservers:
      children:
        ns_primary:
          hosts:
            ns1:
              ansible_host: 198.51.100.10
              hostname: ns1
              primary_ip: 198.51.100.10
              public_ip: 198.51.100.10
              powerdns_name: ns1.example.com
        ns_followers:
          hosts:
            ns2:
              ansible_host: 198.51.100.11
              hostname: ns2
              primary_ip: 198.51.100.11
              public_ip: 198.51.100.11
              powerdns_name: ns2.example.com
    nodes:
      hosts:
        node1001:
          ansible_host: 203.0.113.10
          hostname: node1001
          primary_ip: 10.100.1.10
          public_ip: 203.0.113.10
          region: exm001
          az: exm-001
          container_network: 10.100.4.0/22
          container_network_name: net-exm-001
          app_domain: exm-001.usercontent.example.com
```

### Environment settings

Edit `inventories/prod/group_vars/all/main.yml`:

```yaml
ansible_user: root

cs_portal_domain: portal.example.com
cs_registry_domain: cr.example.com
cs_metrics_domain: metrics.example.com
cs_app_zone: usercontent.example.com
cs_admin_email: admin@example.com

locale: en
currency: USD

dns_driver: powerdns

acme_ca: zerossl
acme_account_email: admin@example.com
```

| Setting | Description |
| --- | --- |
| `ansible_user` | Must be `root`. |
| `cs_portal_domain` | The portal and API domain. |
| `cs_registry_domain` | The container registry domain. |
| `cs_metrics_domain` | The metrics domain. On a multi-site installation, this is the default for any metrics server that doesn't set its own `metrics_domain`. |
| `cs_app_zone` | The parent domain for customer container hostnames. |
| `cs_admin_email` | The email address for the first administrator account. |
| `locale`, `currency` | The platform's default locale and billing currency. |
| `dns_driver` | `powerdns` to use the bundled nameservers, or `none` to skip them. |
| `acme_ca` | The certificate authority. See [TLS certificates](#tls-certificates). |
| `acme_account_email` | The email address registered with the certificate authority. |

!!! note
    The example file lists `autodns` as a `dns_driver` value. It isn't supported by the installer yet; use `none` and configure AutoDNS in the controller's admin area after installation.

### Secrets

Edit `inventories/prod/group_vars/all/secrets.yml`. First, generate the two permanent keys, **once**:

```bash
openssl rand -hex 64   # secret_key_base
openssl rand -hex 64   # user_auth_secret
```

!!! danger "These two keys can never change"
    `secret_key_base` encrypts every credential the controller stores, including agent tokens, DNS keys, and load balancer certificates. If it changes, the controller doesn't report an error. It quietly loses access to all of them, and the symptoms (failing DNS, unreachable nodes, broken TLS) appear days later. Changing either key means reinstalling. Keep a copy of this file somewhere safe, alongside your database backups.

Then fill in the rest. `openssl rand -hex 32` is fine for each of them.

| Setting | Description |
| --- | --- |
| `cs_admin_password` | The password for the first administrator account. |
| `node_enrollment_token` | A shared token used when nodes enroll with the controller. |
| `postgres_password` | The controller's database password. Use only URL-safe characters. |
| `prometheus_basic_auth_password` | The password protecting Prometheus on the metrics servers. |
| `loki_basic_auth_password` | The password protecting Loki on the metrics servers. |
| `backups_key` | The passphrase that encrypts customer backups. |
| `pdns_api_key`, `pdns_web_key`, `pdns_db_password` | PowerDNS credentials. Needed when `dns_driver` is `powerdns`. |
| `haproxy_stats_password` | *Optional, recommended.* The password for each load balancer's statistics page. |

Then encrypt the file:

```bash
ansible-vault encrypt inventories/prod/group_vars/all/secrets.yml
```

You'll enter the vault password each time you run the provisioner.

## 3. Choose optional features

### Tailscale

Add `tailscale_authkey` to `secrets.yml` and every server joins your Tailscale network. The controller then reaches each node's agent, and Prometheus scrapes each node, over that encrypted network.

To keep a server off the tailnet, for example a region on the same private network as the controller, set `tailscale_enabled: false` on that server or its group.

Without Tailscale, a region that doesn't share a private network with the controller sends that traffic unencrypted. If a remote node can't reach the controller's `primary_ip`, set `controller_acme_address` on the node to an address it can reach.

### TLS certificates

The installer requests certificates for the portal, metrics, and registry domains from the CA set in `acme_ca`:

| `acme_ca` | Certificate authority |
| --- | --- |
| `zerossl` | ZeroSSL (the default). |
| `letsencrypt` | Let's Encrypt. |
| `letsencrypt_test` | Let's Encrypt staging. Untrusted certificates, for test environments. |
| `google` | Google Trust Services. Also set `acme_eab_kid` in `main.yml` and `acme_eab_hmac_key` in `secrets.yml`. |
| `buypass`, `sslcom` | Buypass or SSL.com. |

You can also set `acme_ca` to the full URL of any ACME directory.

!!! tip
    Use `letsencrypt_test` for environments you'll rebuild often. Production Let's Encrypt allows only five duplicate certificates per week for the same names.

By default, certificates are validated over HTTP on port 80. To use DNS validation instead, set `acme_challenge_method` to your DNS provider and add its credentials, with the secret ones in `secrets.yml`. For example, for Cloudflare:

```yaml
# group_vars/all/main.yml
acme_challenge_method: "cloudflare"
acme_cf_account: "<account id>"

# group_vars/all/secrets.yml
acme_cf_token: "<API token with write access to the zone>"
```

The [provisioner's ACME guide](https://github.com/ComputeStacks/ansible-install/blob/main/docs/acme-providers.md) lists every supported provider and the settings each one needs.

### Ubuntu Pro

Add `ubuntu_pro_token` to `secrets.yml` to attach every server to Ubuntu Pro and enable Livepatch.

### Error reporting and exports

- Set `sentry_dsn` in `secrets.yml` to send controller errors to Sentry.
- To enable exports to S3-compatible storage, set `cs_agent_s3_export_bucket` in `main.yml`, and `s3_export_access_key` and `s3_export_secret_key` in `secrets.yml`.

### Automatic reboots

When a server has pending updates that need a reboot, the provisioner reboots it during the run. Every re-run can therefore reboot your controller and nodes, which interrupts customer containers and seals the controller's Vault until the run unseals it again. To prevent this, set `common_allow_reboot: false` and schedule reboots yourself.

### A private controller image

To install a controller image from a private registry, set `controller_image_repo` (and `controller_image_tag`, if needed) as host variables on the controller in `hosts.yml`, and add the registry's credentials to `secrets.yml`:

```yaml
docker_registries:
  - registry: registry.example.com
    username: "deploy-user"
    password: "CHANGEME"
```

The registry must have a publicly trusted TLS certificate. If the credentials expire, pulls and controller upgrades fail until you replace them.

!!! warning
    Set the controller image settings in `hosts.yml` on the controller itself. The same settings in `group_vars/all/main.yml` are silently ignored.

## 4. Check connectivity

Confirm that Ansible can reach every server:

```bash
ansible -i inventories/prod all -m ping --ask-vault-pass
```

## 5. Run the installer

```bash
make site ENV=prod
```

or, without `make`:

```bash
ansible-playbook -i inventories/prod playbooks/site.yml --ask-vault-pass
```

!!! warning
    Don't use `--limit` on the first run. If you use Tailscale, the provisioner learns each server's tailnet address during a full run and caches it in the project directory, so a limited run is only safe after one full run from that same copy of the provisioner.

The first run takes a while. It installs Docker and the other packages, pulls images, issues certificates, sets up the controller's database, configures your locations, availability zones, and nodes in the controller, enrolls each node, and then checks the result. Along the way:

1. **Preflight** checks your inventory and servers. It fails immediately on a missing setting, a duplicate availability zone, a short `secret_key_base`, a server that isn't Ubuntu 26.04, or DNS that isn't ready: with the bundled nameservers, a customer zone that isn't delegated to them; otherwise, missing load balancer records. Nothing has changed on your servers at that point.
2. **Vault** initializes and unseals on its own. There's nothing to do by hand.
3. **The controller is seeded** with your locations, availability zones, nodes, networks, load balancers, default products, and administrator account.
4. **Each node enrolls** with the controller.
5. **Validation** checks the whole installation. See [Verify the installation](after-installation.md#verify-the-installation).

If the run fails, fix the problem and run it again. The provisioner is safe to re-run; see [Troubleshooting](troubleshooting.md).

## Next steps

Continue to [After installation](after-installation.md).
