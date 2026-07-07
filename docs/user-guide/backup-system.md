# Backup System

Included in ComputeStacks, is a powerful backup solution that allows for both automated and on-demand backups of your volumes.

## Key Features

- De-Duplication of stored data
- Encrypted
- Built-in MySQL agent for low-impact, point in time snapshots.
- Control how often backups are taken, and how many copies to keep
- 1-click restore

## Configuring Backups

Backups are configured on a per-volume basis, and not per-container. It is primarily for this reason we recommend using a single volume with your container.

**Backups Enabled**

Enable or Disable backups

**Data Type**

The default is ***Files***, which will just perform a file-level snapshot. Choosing another option will use a specific recipe for that data type.

---

**Schedule**

The cron syntax is a powerful way of defining how often a particular job should run. Using this, you can fully customize when your backup jobs are performed.

We also include some helpful shortcuts, which we recommend for most users:

```
@hourly
@daily (or @midnight)
@weekly
@monthly
@yearly (or @annually)
```

```
* * * * * *
| | | | | |
| | | | | +-- Year              (range: 1900-3000) (optional field)
| | | | +---- Day of the Week   (range: 0-6, 0 standing for Sunday)
| | | +------ Month of the Year (range: 1-12, 1 standing for Jan)
| | +-------- Day of the Month  (range: 1-31)
| +---------- Hour              (range: 0-23)
+------------ Minute            (range: 0-59)
```

***Note:** The maximum frequency is every **15 minutes** for the file-based volumes, and hourly for everything else.*

**Retention Settings**

Each option corresponds to a backup slot that will be filled. However, if only 1 backup exists that meets multiple retention slots, then only 1 backup will be kept.

For example, if you have a `Retention` setting of 1 Hourly, and 1 Daily, and your `Schedule` is `@hourly`, then at the end of the day you will have 2 backups. 1 Hourly, and 1 Daily.

If, for example, had a `Schedule` of `@daily`, you would only have 1 backup.

**Custom Hooks**

Tell ComputeStacks to run scripts *inside* your container during certain points of the backup & restore process. You must ensure that your script exits with code `0`, otherwise we will assume the script failed.

It's also important that you wrap your scripts in `bash` or `sh`.

```bash
/bin/bash /path/to/script
/bin/bash -c "whoami"
```

!!! note
    For all of our *Data Types*, we already configure snapshots before a restore is performed. This allows us to recover from a failed restore.

test
