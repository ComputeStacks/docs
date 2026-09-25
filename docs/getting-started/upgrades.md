# Upgrades

## The controller

The controller follows a minor release line, such as `9.7`. To pick up the latest patch release in that line, run this on the controller:

```bash
cstacks upgrade
```

It backs up the database first, then pulls the new image, runs any migrations, and restarts the controller. If the backup fails, the upgrade stops before changing anything.

Re-running the installer also upgrades the controller whenever the running image doesn't match the configured one.

To move to a new minor or major release, read that release's notes first. Then set `controller_image_tag` on the controller in `hosts.yml`, for example `controller_image_tag: "9.8"`, and re-run the installer.

## Everything else

Every other component the provisioner installs, such as Docker, the ComputeStacks agent, borg, Prometheus, and Loki, is pinned to an exact version. Nothing upgrades on its own: these packages are held so that unattended upgrades can't move them.

To upgrade them, upgrade the provisioner and re-run it:

```bash
cd computestacks
git pull
make deps
make site ENV=prod
```

The installer converges every server to the pinned versions and restarts services as needed. Operating system security updates are installed automatically by unattended upgrades.
