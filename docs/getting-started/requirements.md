# Requirements

Before you install, prepare your workstation, the servers, the network, and a few accounts. The [provisioner](https://github.com/ComputeStacks/ansible-install) checks most of these at the start of every run, before it changes anything.

## Your workstation

You run the provisioner from a *control machine*, usually your own workstation or a CI runner. It needs:

- **ansible-core 2.19** or newer.
- The Python **`cryptography`** library. Some certificate checks run on the control machine rather than on the servers.
- **`dig`**, used to check your load balancer DNS records before the install starts. It's in the `dnsutils` package (Debian/Ubuntu) or `bind` (macOS with Homebrew).
- `git` and `make`.
- SSH access to every server as `root`, by key.

The Ansible roles and collections the provisioner depends on are pinned, and installed into the project directory in a later step. You don't install them globally.

## Servers

See the [Architecture Overview](architecture-overview.md#example-configurations) for sizing. Every server must be:

- **Ubuntu 26.04 LTS on amd64**, freshly installed. Other distributions, releases, and architectures are rejected.
- **Reachable over SSH as `root` with a key.** The provisioner doesn't use `sudo`, and the controller also uses root SSH to the nodes and registry at runtime.
- **Named with a single lowercase word**, such as `node101`, not `node101.example.com`. The hostname on the server must match the name you give it in the inventory.

    ```bash
    hostnamectl set-hostname node101
    ```

Each server needs a private address for the control plane and a public address. They may be the same.

!!! tip "Ubuntu cloud images block root login"
    Ubuntu cloud images install your SSH key for `root` behind a forced command that says "Please login as the user ubuntu". Add `disable_root: false` to the server's cloud-init user data.

The provisioner installs everything else it needs. It disables password SSH login, and it removes `ufw` and `ntp` if they are present, replacing them with its own nftables firewall and chrony.

### Container networks

Each container node needs a private network range for its containers:

- RFC 1918 private addresses.
- At least a `/28`. A `/22` is typical.
- It must not overlap any other network in your environment, including other nodes' container networks.

## Network

The provisioner configures each server's firewall. Your provider's network, and any firewall in front of your servers, must allow the following.

| Traffic | Ports | To |
| --- | --- | --- |
| Customer web traffic | 80, 443 TCP | Container nodes |
| Customer TCP/UDP services | 10000–50000 TCP and UDP | Container nodes |
| Portal, API, and certificate issuance | 80, 443 TCP | Controller |
| Certificate issuance (HTTP-01) | 80 TCP | Metrics and registry servers |
| DNS | 53 TCP and UDP | Nameservers |
| SSH | 22 TCP | Every server, from your control machine and the controller |
| Tailscale (optional) | 41641 UDP | Every server |

Traffic between servers on the private network (Docker TLS on 2376, the agent on 8500, metrics scrapes, PostgreSQL replication, and so on) is opened by the provisioner's own firewall rules, limited to the servers that need it.

Every server also needs outbound HTTPS to download packages and images, including from `download.docker.com`, `apt.postgresql.org`, `repo.computestacks.com`, `ghcr.io`, Docker Hub, and GitHub.

!!! warning "Remote regions and cleartext traffic"
    Without a private network or Tailscale, the controller's requests to each node's agent and Prometheus's scrapes of each node cross the public internet unencrypted. That is a supported choice, but make it deliberately. See [Tailscale](install.md#tailscale).

If port 80 can't be opened to the internet on the controller, metrics, or registry servers, use a DNS-01 challenge for their certificates instead. See [TLS certificates](install.md#tls-certificates).

## Accounts

**Required:**

- An email address for your **ACME certificate authority** account. The default CA is [ZeroSSL](https://zerossl.com); Let's Encrypt, Google Trust Services, Buypass, and SSL.com are also supported.
- Control of a **public DNS domain** for the portal, metrics, registry, and customer container hostnames. See [Prepare DNS](dns.md).

**Optional:**

- A **Tailscale** auth key, to encrypt control-plane traffic between sites.
- An **Ubuntu Pro** token, for Livepatch.
- API credentials for your **DNS provider**, if you use DNS-01 certificate challenges.
- A **Sentry** DSN, for error reporting from the controller.
- **S3-compatible storage** keys, for exports.

The ComputeStacks controller image is published publicly at `ghcr.io/computestacks/controller`, so no registry credentials are needed to install it.

## Next steps

Continue to [Prepare DNS](dns.md).
