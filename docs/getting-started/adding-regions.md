# Add Regions and Nodes

Each availability zone has exactly one container node, so adding capacity means adding an availability zone, and optionally a new region (location) to hold it.

## An environment installed with the current provisioner

1. Add the new node to `hosts.yml` in your existing inventory, with its own `az`, `container_network`, `container_network_name`, and `app_domain`. Give it an existing `region`, or a new one.
2. If the node is in a new facility, add a metrics server for that site too, and optionally a backup server, and set the same `site` on all of them.
3. If you manage the [load balancer DNS records](dns.md#load-balancer-records) yourself, create them for the new availability zone. With the bundled nameservers, the installer writes them for you.
4. Re-run the installer against the whole inventory:

    ```bash
    make site ENV=prod
    ```

The run creates the new location, availability zone, node, and load balancer in the controller, and updates the metrics servers and every server's firewall to include the new node. Existing servers are brought back in line with your inventory, but nothing already in the controller is overwritten.

!!! danger "Don't limit the run to the new region"
    `--limit region_<name>` selects only that region's **nodes**. The controller, metrics, backup, and nameservers are left out, so the run skips registering the node with the controller, updating the shared servers, and writing the new load balancer records, and still finishes without an error. If you must limit a run, name the shared servers as well, for example `--limit 'region_exm002:controller:metrics:backup:nameservers'`.

A limited run is fine for re-applying configuration to a node that is already registered, as long as this copy of the provisioner has completed at least one full run. See the warning in [Run the installer](install.md#5-run-the-installer).

## An environment installed with the previous (v1) installer

Environments built with the earlier, Debian-based installer can't be re-run with the current provisioner. Instead, *attach mode* adds a new Ubuntu 26.04 region to them, and makes only additive changes to your existing servers.

Before you start:

- Upgrade the controller to a release that supports attach mode. The installer checks this before changing anything.
- Build a separate inventory containing your existing **shared** servers (controller, metrics, backup, registry, and nameservers) and the **one new node**. Don't include any existing nodes: an existing node marked as existing stops the run, and one that isn't marked would be rebuilt from scratch.
- Mark every existing shared server with `existing_env: true`. Don't mark the new node.
- Copy `secret_key_base` **exactly** from `/etc/default/computestacks` on the existing controller into your `secrets.yml`. The installer checks it and stops if it doesn't match.
- Use your existing `backups_key` and your existing metrics server's basic-auth credentials.
- Describe your existing backup server with `backup_host_path: /mnt` and `backup_borg_remote_path: /usr/bin/borg`. Without them, backups from the new node fail.
- Give the new node its own `app_domain`, different from `cs_app_zone`.
- With `dns_driver: powerdns`, include your existing nameservers in the same shape as a full inventory: a `nameservers` group with `ns_primary` and `ns_followers`, each marked `existing_env: true`. The run then writes the new availability zone's load balancer records on the existing primary nameserver. Without the nameservers in the inventory, or with `powerdns_manage_lb_records: false`, create the [load balancer records](dns.md#with-any-other-dns) yourself before the run.
- If you set `tailscale_authkey`, set `tailscale_enabled` explicitly on every server in the inventory.

Then run:

```bash
make add-region ENV=prod
```

Don't use `--limit` with attach mode. The run pauses once to show you the changes it will make to the controller, and it restarts the portal, which causes up to a minute of downtime.

To re-run the checks for an attached region later, use `make add-region-validate ENV=prod` rather than `make validate`.

Read the provisioner's [attach mode guide](https://github.com/ComputeStacks/ansible-install/blob/main/docs/attach-mode.md) before you start. It lists every change made to the existing servers and every setting that must match your existing environment.
