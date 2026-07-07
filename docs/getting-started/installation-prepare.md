# Installation: Prepare

If you will be deploying to a cloud provider, please first check to see if we have a [terraform package](https://github.com/ComputeStacks?q=terraform&type=all&language=&sort=) for your provider. This will aid you in ensuring certain required steps are performed first.

!!! tip
    We highly recommend using our terraform provider, or at least modify one to work with your desired provider. A lot of the installation challenges come from running our ansible installer on a platform we have not used.

## Setup Ansible

### Install Ansible

Please see the [ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) for more details on how to proceed with installing ansible.

??? note "Install On Mac Os"
    
    Ensure you have [homebrew](https://docs.brew.sh/Installation) installed, and run: `brew install ansible`
    
??? note "Install On Linux"
    
    To ensure you have an up-to-date copy of Ansible, we recommend using `pip` to install ansible.
    
    ```bash
    pip install --user ansible
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```
    
    *Note: For some distributions, it may be `~/.bash_profile` instead of `.bashrc`.*
    

### Download our Ansible Package

**QUICK INSTALL**

1. Download latest zip from [https://github.com/ComputeStacks/ansible-install](https://git.cmptstks.com/cs-public/ops/ansible-install/-/releases/permalink/latest)
2. Decompress and open directory
    
    ```bash
    mv inventory.yml.sample inventory.yml
    make roles
    ```
    
- **INSTALL FROM GIT (OPTIONAL)**
    
    ```bash
    git clone https://github.com/ComputeStacks/ansible-install.git computestacks-installer
    cd computestacks-installer
    git checkout $(git describe --abbrev=0) # This will switch to the most recent tag
    mv inventory.yml.sample inventory.yml
    make roles
    ```
    

!!! tip
    If you used our terraform providers, you can skip the `mv inventory.yml.sample inventory.yml` command and copy the `result/inventory.yml` file to the root of this directory.

!!! warning
    The actual bootstrap process can take **up to an hour**, so we recommend you setup your ansible environment on a remote linux server, and run either `tmux` or `screen`.

### Inventory File

Please review your `inventory.yml` file and ensure all the settings are correct. You may check the `roles/<role>/defaults/main.yml` file for *each role* to see additional configuration options.

## Prepare the servers

### Server Hostnames

Ensure all hostnames are configured properly on each node. Our system expects the hostnames on nodes to be 1 lowercase word (dashes or underscores are ok), no special characters or spaces. They should not be FQDN or have the dot notation.

Examples: `node101`, `node102`, `node103`

```bash
hostname node101 && echo "node101" > /etc/hostname && echo "127.0.0.1 node101" >> /etc/hosts
```

The reason these are critical are two fold:

**a)** When metrics are stored for containers or nodes, the hostname is added as a label. This is how ComputeStacks is able to filter metrics for the correct container/node.

**b)** Backup jobs are assigned to the node by their hostname. If there is a mismatch in the controller, then jobs will not run.

### Base Packages

Please ensure the following packages have been installed prior to running the ansible installation.

```bash
apt update && apt -y install openssl ca-certificates linux-headers-amd64 python3 python3-pip python3-openssl python3-apt python3-setuptools python3-wheel
```

---

**Next Step:** [Perform Installation](installation-perform.md)
