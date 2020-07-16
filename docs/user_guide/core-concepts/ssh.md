---
title: SSH & File Access
description: SSH & File Access
---
# Connecting to your container

## Overview
Unlike a traditional hosting environment, ssh & sftp access is not available directly for containers. To be able to offer this convenience, we deploy a special ssh container inside your project. 

## Finding your login details
To view the connection details, you will navigate to your *Container Service* and look for the section titled "SFTP & SSH Details". If you just deployed your service, you may have to wait for a few minutes for this to appear.

!!! tip ""
    Be sure to take note of the volume path below your credentials. You will need to drill into that directory to find your files.

You can use either an SFTP client like Transmit, or connect directly via SSH.

If you connect via SSH, you will find many of the most common tools such as: git, vim, npm, wpcli, and compose.

You may also use this SSH container as your bastion portal to your other containers within that deployment.