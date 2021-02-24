---
title: Sending Mail
description: Sending Mail
---
# How to send mail

By default, none of [our images](https://hub.docker.com/u/cmptstks){: target="_blank" } include any kind of MTA. 

!!! danger ""
    Some of our providers explicitly block port `25` on their container nodes, so even if you add an MTA to your container image, sending mail may still fail.

In addition to the technical limitations, due to the lack of mail volume and other factors, mail sent from your container may fail to reach the intended recipient. For this reason, we advise all our customers to use a third-party SMTP service.

Example SMTP services:

* [Postmark](https://postmarkapp.com){: target="_blank" }
* [Sendinblue](https://www.sendinblue.com){: target="_blank" }
