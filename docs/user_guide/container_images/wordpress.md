---
title: Wordpress
description: Wordpress
---
# Wordpress

ComputeStacks offers an [Open LiteSpeed](https://openlitespeed.org){: target="_blank" } based container image, designed to offer compatibility with common `.htaccess` directives, while offering [exceptional performance](https://openlitespeed.org/benchmarks/wp-http2/){: target="_blank" }.

## Caching Plugin

Litespeed has developed their own [caching plugin](https://wordpress.org/plugins/litespeed-cache/){: target="_blank" }, which we highly recommend you use. We have found stability issues with other popular wordpress plugins.

The Litespeed plugin has full support for adding a Redis cache.

## Sending Mail

Beginning with our [php7.4](https://git.cmptstks.com/cs-public/images/wordpress/-/tree/main/php7.4-litespeed) image, we now include a built-in MTA to allow wordpress to send mail _without any kind of additional plugin_. However, by default this is disabled.

To activate mail, find an SMTP provider of your choice such as Postmark, SendInBlue, Sendgrid, or Mailgun, and edit your wordpres service and add the following environmental variables: 

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Required</th>
      <th>Value</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>SMTP_SERVER</td>
      <td>Yes</td>
      <td>IP or Hostname of the SMTP server</td>
      <td><pre>null</pre></td>
    </tr>
    <tr>
      <td>SMTP_PASSWORD</td>
      <td>Yes</td>
      <td>SMTP Password</td>
      <td><pre>null</pre></td>
    </tr>
    <tr>
      <td>SMTP_USERNAME</td>
      <td>Yes</td>
      <td>Username</td>
      <td><pre>null</pre></td>
    </tr>
    <tr>
      <td>SMTP_PORT</td>
      <td>Yes</td>
      <td>smtp port</td>
      <td><pre>null</pre></td>
    </tr>
    <tr>
      <td>PM_STREAM</td>
      <td>No</td>
      <td>Postmark Message Stream ID</td>
      <td><pre>null</pre></td>
    </tr>
  </tbody>
</table>


Please see our [guide to sending mail](../core-concepts/mail.md).

## WP CLI
[wp](https://wp-cli.org){: target="_blank" } is installed and ready to use via our [SSH](../core-concepts/ssh.md) container.