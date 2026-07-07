# Controller Backups

There are different ways to configure backups for your controller, however we recommend the following:

1. If you have virtualized the controller in a virtual machine, implement regular backups of the entire virtual machine.
2. Implement our automated offsite database backups. You can read more how to implement this by visiting our github repository [git.cmptstks.com/cs-public/ops/controller-backups](https://git.cmptstks.com/cs-public/ops/controller-backups). For our customers with a support plan including remote server support, please open a ticket and we can help configure this for you.

## Take Backup

Database backups can be taken manually at anytime by running `cstacks database-backup`. This will created a compressed backup under `/var/lib/computestacks/backups`.

## Restoring a backup

To restore a backup, `cd` to the backup directory and run `gzip -d <filename> && psql cloudportal < <filename-without-gz>`.

For example, if the database backup is: `cloudportal-20200617-0940_53.sql.gz`, then you would run:

!!! danger
    I don't recommend copy/pasting the entire block below and running it. Instead, copy each line *one-by-one* and run it to make sure it's successful.

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
