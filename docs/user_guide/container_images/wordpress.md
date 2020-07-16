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

By default, none of [our images](https://hub.docker.com/u/cmptstks){: target="_blank" } include any kind of MTA. Additionally, some of our providers explicitly block port `25` on their container nodes. 

Our default wordpress image includes an smtp plugin that you may activate and use.

Please see our [guide to sending mail](../core-concepts/mail.md).

## WP CLI
[wp](https://wp-cli.org){: target="_blank" } is installed and ready to use via our [SSH](../core-concepts/ssh.md) container.