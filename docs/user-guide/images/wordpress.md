# Image: Wordpress

ComputeStacks offers an [Open LiteSpeed](https://openlitespeed.org/) based container image, designed to offer compatibility with common `.htaccess` directives, while offering [exceptional performance](https://openlitespeed.org/benchmarks/wp-http2/).

## Caching Plugin

Litespeed has developed their own [caching plugin](https://wordpress.org/plugins/litespeed-cache/), which we highly recommend you use. We have found stability issues with other popular wordpress plugins.

The Litespeed plugin has full support for adding a Redis cache.

## Sending Mail

Beginning with our [php7.4](https://git.cmptstks.com/cs-public/images/wordpress/-/tree/main/php7.4-litespeed) image, we now include a built-in MTA to allow wordpress to send mail *without any kind of additional plugin*. However, by default this is disabled.

To activate mail, find an SMTP provider of your choice such as Postmark, SendInBlue, Sendgrid, or Mailgun, and edit your wordpres service and add the following environmental variables:

| **Name** | **Required** | **Value** | **Default** |
| --- | --- | --- | --- |
| SMTP_SERVER | Yes | IP or Hostname of the SMTP server | `null` |
| SMTP_PASSWORD | Yes | SMTP Password | `null` |
| SMTP_USERNAME | Yes | SMTP Username | `null` |
| SMTP_PORT | Yes | Port | `null` |
| PM_STREAM | No | Postmark Message Stream ID | `null` |

!!! note
    Please see our [guide to sending mail](../concepts/sending-mail.md).

## WP CLI

[WP-CLI](https://wp-cli.org) is installed and ready to use via our [cloud shell](../concepts/ssh-and-sftp-access.md).
