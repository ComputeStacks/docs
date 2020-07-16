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
Backups are configured on a per-volume basis, and not per-container. It is primarily for this reason we recommend using on a single volume with your container.

## TODO

* Customize retention settings
* Understanding the _extra commands_ section
* How does a restore process work