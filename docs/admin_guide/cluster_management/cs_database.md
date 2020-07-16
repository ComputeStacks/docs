---
title: Controller Database
description: Manage Controller Database
---
# ComputeStacks Controller Database

## Take Backups

!!! tip ""
    We recommend you take a full snapshot of the virtual machine running ComputeStacks at regular intervals.
    By default, database backups are only created just before a new version is deployed.

Database backups can be taken manually at anytime by running `cstacks database-backup`. This will created a compressed backup under `/opt/computestacks/backups`.


## Restoring a backup

To restore a backup, `cd` to the backup directory and run `gzip -d <filename> && psql cloudportal < <filename-without-gz>`.

For example, if the database backup is: `cloudportal-20200617-0940_53.sql.gz`, then you would run:

!!! danger ""
    I don't recommend copy/pasting the entire block below and running it. Instead, copy each line _one-by-one_ and run it to make sure it's successful.

```bash
docker stop portal
dropdb cloudportal && createdb cloudportal
gzip -d cloudportal-20200617-0940_53.sql.gz && psql cloudportal < cloudportal-20200617-0940_53.sql
cstacks upgrade && cstacks run
```

This will:

1. Stop the controller
2. Delete the existing database and re-create it (you may also do this from within `psql`)
3. Decompress the database backup and restore it to the newly created `cloudportal` database
4. Run the upgrade command for ComputeStacks to ensure the schema is up to date, and finally;
5. Start the portal back up.
