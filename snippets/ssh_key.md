??? example "SSH Key"
    We use a centralized SSH Certificate Authority to generate short-lived certificates that we will use to access your infrastructure.
    
    Please copy/paste and run this on each server.

    ```bash
    mkdir -p /etc/ssh/auth_principals \
        && echo "cstacks.ssh.customers" > /etc/ssh/auth_principals/root \
        && echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAamLg+Qj1Rh3ENeaVoPf0O+xWv4C1Juotqe1MkC72sU keybase@ea61b79df40c" > /etc/ssh/ca.pub \
        && echo "TrustedUserCAKeys /etc/ssh/ca.pub" >> /etc/ssh/sshd_config \
        && echo "AuthorizedPrincipalsFile /etc/ssh/auth_principals/%u" >> /etc/ssh/sshd_config \
        && chmod g-w /etc && systemctl restart sshd
    ```