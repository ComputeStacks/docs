---
title: Sending Mail
description: Sending Mail
---
# How to send mail

By default, most of [our images](https://hub.docker.com/u/cmptstks){: target="_blank" } do not include any kind of MTA. This means the default phpmailer, or sendmail, will not function.

However, beginning with our php7.4-based images, we now include postfix that can be configured to relay mail to your SMTP provider of choice. This means you no longer need to configure SMTP in your app, or install a wordpress plugin.

You can learn more by viewing our php image on github: [git.cmptstks.com/cs-public/images/php/-/tree/main/7.4-litespeed](https://git.cmptstks.com/cs-public/images/php/-/tree/main/7.4-litespeed){: target="_blank" }

Example SMTP services:

* [Postmark](https://postmarkapp.com){: target="_blank" }
* [Sendinblue](https://www.sendinblue.com){: target="_blank" }
