# How-To: Export a Backup

To restore and export a backup from the ComputeStacks backup agent, you will need administrator access to one of the nodes that has access to that particular backup.

---

## Step 1: Prepare the machine

1. Login via ssh and gain root access.
2. Create an export directory, for example `/root/backup-export`.
    
    ```bash
    cd /root && mkdir backup-export
    ```
    

## Step 2: Launch a backup container with the data mounted

1. Aquire the backup encryption key. This can be found in `/etc/computestacks/agent.yml` under `backups.key`.
    
    !!! warning
    If your key has a `$` character in it, be sure to escape that before adding it to the container (`\$`).

    
2. Determine the backup volume name.
    1. Login to the ComputeStacks controller and navigate to: the project → data volumes → click on the volume
    2. Below the overview details, you will see a UUID in the gray footer. The backup volume name will be: `b-<the-volume-UUID>`.
3. Create the backup container. 
    
    ```bash
    docker run -it --rm -l com.computestacks.role=backup \
                        -e BORG_PASSPHRASE="BACKUP-KEY" \
                        -e BORG_BASE_DIR=/mnt/borg \
                        -v b-{{ volume-UUID }}:/mnt/borg \
                        -v /root/backup-export:/mnt/export \
                        cmptstks/borg:stable ash
    ```
    
    This will launch the container and place you into an interactive shell.
    

## Step 3: Extract your backup data

1. List all available backups
    
    ```bash
    borg list /mnt/borg/backup
    ```
    
    !!! note
    [https://borgbackup.readthedocs.io/en/stable/usage/list.html](https://borgbackup.readthedocs.io/en/stable/usage/list.html)

    
2. *(Optional)* List files in the backup
    
    ```bash
    # example: borg list /mnt/borg/backup::test-m-2022-10-12T22:34:43
    borg list /mnt/borg/backup::{{ archive name outputted in previous command }}
    ```
    
3. Extract backup into directory
    
    ```bash
    # example: cd /mnt/export && borg extract /mnt/borg/backup::test-m-2022-10-12T22:34:43
    cd /mnt/export && borg extract /mnt/borg/backup::{{ archive name outputted in previous command }}
    ```
    
    !!! note
    [https://borgbackup.readthedocs.io/en/stable/usage/extract.html](https://borgbackup.readthedocs.io/en/stable/usage/extract.html)

    
4. You may now exit the container:
    
    ```bash
    exit
    ```
    
    *The container will be automatically stopped & deleted upon exit.*
    

## Step 4: Cleanup

Your files will now be in the directory you initially setup *(e.g. `/root/backup-export`).* You can now compress that entire directory and transfer it wherever it needs to go.
