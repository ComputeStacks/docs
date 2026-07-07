# Troubleshoot Backup Issues

# Backups Fail with `Failed to create/acquire the lock`

This can happen if a backup operation was interrupted. To recover from this, you’ll need to enter the backup repository and break the lock.

SSH into the node that holds this backup, and enter a backup container with:

Replace `VOLUME-ID` with the ID of the volume. This can be found by viewing the volume in the administrator of ComputeStacks. It should be in the form of a UUID, however it may be a long string of lowercase letters and numbers if the volume was created by docker and later imported by ComputeStacks.

```bash
VOLID=VOLUME-ID; docker run --rm -it --label "com.computestacks.role=backup" -e "BORG_BASE_DIR=/mnt/borg" -e "BORG_REPO=/mnt/borg/backup" -v b-$VOLID:/mnt/borg -v $VOLID:/mnt/data ghcr.io/computestacks/cs-docker-borg:1.4 /usr/bin/borg break-lock
```
