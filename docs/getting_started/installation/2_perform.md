---
title: Perform Installation
description: Perform Installation
---
# Perform Installation

## Preflight Checklist

Before you run the ansible package, lets quickly run through our checklist and make sure we have everything done.

**Servers**

- [ ] Servers have been created with the minimum requirements
- [ ] Required base packages have been installed
- [ ] Hostnames have been configured, and are a single-word without a domain.
- [ ] You have verified connectivity between the servers

**Domains**

- [ ] Domains have been identified, and;
- [ ] their DNS records have been set

**Inventory File**

- [ ] You've generated passwords: backups key, prometheus, and loki
- [ ] Domain names have been added
- [ ] License Key is added, and active
- [ ] Default Admin account is defined
- [ ] All servers and their respective public/private IP addresses have been added
- [ ] The Floating IP Address has been defined _(if applicable)_
- [ ] You've added your ip addresses to the `extra_allowed_ipv4_addresses` section

---

## Run Installer

Now that your `inventory.yml` file has been configured, and all servers are prepared, you may now run the ansible bootstrap script.

```bash
ansible-playbook -u root -i inventory.yml main.yml --tags "bootstrap"
```

Depending on how many servers you're provisioning, this process may take **_up to an hour_**.

## Validate Installation

The very last step of the ansible package is to reboot all the servers. Once they come back online, you can run the following command, which performs a series of sanity checks to make sure everything is running.

```bash
ansible-playbook -u root -i inventory.yml main.yml --tags "validate"
```

---
Next Step: [Finalize Installation](3_finalize.md)

---

## Troubleshooting

Occasionally a task may fail during the bootstrap process due to various reasons, such as:

* Temporary network or dns issue
* hardware issue with the server

This can cause complications for your bootstrap process, depending on where it failed. Many of our roles have checks in the `roles/<role-name>/tasks/main.yml` to see if a process has run already to avoid re-running it. This is done by checking for either configuration files present on the system, or if the service is running. If the process failed _after_ a particular configuration file was created, but _before_ all the steps have been completed, the ansible task may skip over the rest thinking it's already done.

In order to get around this, you may need to comment out those checks in the `main.yml` file for that task, and re-run the bootstrap command. Additionally, you may want to comment out tasks that have already run in the main `main.yml` file at the root of the ansible repo to speed up the process.

