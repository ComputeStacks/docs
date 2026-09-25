# Add Regions and Nodes

Each availability zone has exactly one container node, so adding capacity means adding an availability zone, and optionally a new region (location) to hold it.

## An environment installed with the current provisioner

1. Add the new node to `hosts.yml` in your existing inventory, with its own `az`, `container_network`, and `app_domain`. Give it an existing `region`, or a new one.
2. If the node is in a new facility, add a metrics server for that site too, and optionally a backup server, and set the same `site` on all of them.
3. Create the [load balancer DNS records](dns.md#load-balancer-records) for the new availability zone.
4. Re-run the installer against the whole inventory:

    ```bash
    make site ENV=prod
    ```

The run creates the new location, availability zone, node, and load balancer in the controller, and updates the metrics servers and every server's firewall to include the new node. Existing servers are brought back in line with your inventory, but nothing already in the controller is overwritten.

!!! danger "Don't limit the run to the new region"
    `--limit region_<name>` selects only that region's **nodes**. The controller, metrics, and backup servers are left out, so the run skips registering the node with the controller and updating the shared servers, and still finishes without an error. If you must limit a run, name the shared servers as well, for example `--limit 'region_exm002:controller:metrics:backup'`.

A limited run is fine for re-applying configuration to a node that is already registered.

## An environment installed with the previous (v1) installer

Environments built with the earlier, Debian-based installer can't be re-run with the current provisioner. Instead, *attach mode* adds a new Ubuntu 26.04 region to them, and makes only additive changes to your existing servers.

Before you start:

- Upgrade the controller to the current release with `cstacks upgrade`.
- Copy `secret_key_base` **exactly** from `/etc/default/computestacks` on the existing controller into your `secrets.yml`. The installer checks it and stops if it doesn't match.
- Use your existing `backups_key` and your existing metrics server's basic-auth credentials.
- Mark every existing server in the inventory with `existing_env: true`.
- Give the new node its own `app_domain`, different from `cs_app_zone`.

Then run:

```bash
make add-region ENV=prod
```

Don't use `--limit` with attach mode. The run pauses once to show you the changes it will make to the controller, and it restarts the portal, which causes up to a minute of downtime.

Read the provisioner's [attach mode guide](https://github.com/ComputeStacks/ansible-install/blob/main/docs/attach-mode.md) before you start. It lists every change made to the existing servers and every setting that must match your existing environment.
