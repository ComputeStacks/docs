# After Installation

## Verify the installation

The last step of every run checks the things that would otherwise fail silently:

| Check | What it confirms |
| --- | --- |
| `services` | Every expected service is running on each server. |
| `containers` | The portal and Vault containers are running on the controller. |
| `agent` | The controller can reach each node's agent. |
| `backfill` | Each node finished enrolling with the controller. |
| `prometheus` | The controller can query metrics for each node. |
| `borg` | Each node can reach its site's backup server. |
| `ssh` | The controller can reach the nodes and registry over SSH. |
| `portal` | Each node can reach the portal. |
| `acme_backend` | Each node can reach the controller's certificate service. |
| `lb_domain` | The controller has validated each new availability zone's load balancer domain. |
| `dns` | Every nameserver serves the customer zone. |
| `pdns_api` | The PowerDNS API is answering. |
| `dns_replication` | Each follower nameserver is replicating from the primary. |

You can run the checks on their own at any time:

```bash
make validate ENV=prod
```

To skip a check, pass its name to `--skip-tags`, for example `make validate ENV=prod ARGS='--skip-tags borg'`.

!!! note
    The controller validates load balancer domains in the background, a few minutes after they are created. If `lb_domain` reports that the result isn't available yet, wait a few minutes and run it again:

    ```bash
    make site ENV=prod ARGS='--tags lb_domain'
    ```

## Log in

Open `https://<cs_portal_domain>` and log in with `cs_admin_email` and `cs_admin_password`.

The installer has already created your locations, availability zones, nodes, load balancers, a default user group, and a starter set of products. Next:

- Review your [billing plans](../admin-guide/billing/overview.md) and products.
- Schedule [controller database backups](#back-up-the-controller-database).
- Review [resource management](../admin-guide/platform-management/resource-management.md) for your nodes.

## Keep your secrets safe

Store a copy of your encrypted `secrets.yml` and its vault password somewhere outside your control machine. You need the same `secret_key_base` to restore a controller database backup or to add regions later.

The controller's Vault unseal keys are stored on the controller itself, under `/etc/computestacks/.vault-bootstrap/`. Protect root access to the controller accordingly.

## Back up the controller database

Customer volumes are backed up to your backup servers, but **nothing backs up the controller's own database automatically.** Schedule the built-in backup command on the controller, for example with a daily cron entry or systemd timer:

```bash
cstacks database-backup
```

It writes a compressed dump to `/var/lib/computestacks/backups/`. Copy those files off the controller regularly.

To restore a backup, on the controller as root:

```bash
cstacks stop
dropdb cloudportal && createdb -O computestacks cloudportal
zcat /var/lib/computestacks/backups/cloudportal-<stamp>.sql.gz | psql cloudportal
cstacks run
```

!!! warning
    A backup can only be restored with the same `secret_key_base` it was taken under. Keep your `secrets.yml` with your backups.

## The `cstacks` command

The installer adds a `cstacks` command to the controller for day-to-day operation:

| Command | Purpose |
| --- | --- |
| `cstacks run`, `cstacks stop` | Start or stop the controller. |
| `cstacks upgrade` | Back up the database, pull the latest patch release, migrate, and restart. |
| `cstacks database-backup` | Back up the controller database. |
| `cstacks logs`, `cstacks tail-logs` | Show or follow the controller's logs. |
| `cstacks console` | Open a Rails console in the controller container. |
| `cstacks test` | Test the controller's connections to each node: Docker, SSH, and the agent. |

## Next steps

- [Add regions and nodes](adding-regions.md)
- [Upgrades](upgrades.md)
- [Troubleshooting](troubleshooting.md)
