---
title: Backups
description: Manage Backups
---
# Backup System
Included in ComputeStacks, is a powerful backup solution that allows for both automated and on-demand backups of your volumes.

## Key Features

* De-Duplication of stored data
* Encrypted
* Built-in MySQL agent for low-impact, point in time snapshots. 
* Control how often backups are taken, and how many copies to keep
* 1-click restore

## Configuring Backups
Backups are configured on a per-volume basis, and not per-container. It is primarily for this reason we recommend using a single volume with your container.

<table>
<tbody>
    <tr>
        <td><b>Backups Enabled</b></td>
        <td>Enable or Disable backups</td>
    </tr>
    <tr>
      <td><b>Schedule</b></td>
      <td>
        The cron syntax is a powerful way of defining how often a particular job should run. Using this, you can fully customize when your backup jobs are performed.
        <br><br>
        We also include some helpful shortcuts, which we recommend for most users:
        <br>
        <pre>
@hourly
@daily (or @midnight)
@weekly
@monthly
@yearly (or @annually)
        </pre>

        For advanced customization, here is the full syntax:

        <pre>
* * * * * *
| | | | | |
| | | | | +-- Year              (range: 1900-3000) (optional field)
| | | | +---- Day of the Week   (range: 0-6, 0 standing for Sunday)
| | | +------ Month of the Year (range: 1-12, 1 standing for Jan)
| | +-------- Day of the Month  (range: 1-31)
| +---------- Hour              (range: 0-23)
+------------ Minute            (range: 0-59)
        </pre>

        <b>Note:</b> The maximum frequency is every <b>15 minutes</b> for file-based volumes, and hourly for everything else.
      </td>
    </tr>
    <tr>
      <td><b>Data Type</b></td>
      <td>The default is <em>Files</em>, which will just perform a file-level snapshot. Choosing another option will use a specific recipe for that data type.</td>
    </tr>
    <tr>
      <td><b>Retention Settings</b></td>
      <td>
        Each option corresponds to a backup slot that will be filled. However, if only 1 backup exists that meets multiple retention slots, then only 1 backup will be kept.
        <br><br>
        For example, if you have a <em>Retention</em> setting of 1 Hourly, and 1 Daily, and your <em>Schedule</em> is <code>@hourly</code>, then at the end of the day you will have 2 backups. 1 Hourly, and 1 Daily.
        <br><br>
        If, for example, had a <em>Schedule</em> of <code>@daily</code>, you would only have 1 backup.
      </td>
    </tr>
    <tr>
      <td><b>Custom Hooks</b></td>
      <td>
        Tell ComputeStacks to run scripts <em>inside</em> your container during certain points of the backup & restore process. You must ensure that your script exits with code <code>0</code>, otherwise we will assume the script failed.
        <br><br>
        It's also important that you wrap your scripts in `bash` or `sh`.
        <br><br>
        For example:
        <pre>
/bin/bash /path/to/script
/bin/bash -c "whoami"
        </pre>
        <b>Note:</b> For all of our <em>Data Types</em>, we already configure snapshots before a restore is performed. This allows us to recover from a failed restore.
      </td>
    </tr>
</tbody>
</table>
