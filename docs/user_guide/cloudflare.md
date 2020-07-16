---
title: Cloudflare
description: Cloudflare With ComputeStacks
---
# Integrating Cloudflare with ComputeStacks
ComputeStacks offers a number of integration points to enable seamless integration with Cloudflare.

## Real IP
We automatically accept the real visitor IP header from cloudflare and pass that along to your application as our standard real ip header. (see tip about real IP [here](/user_guide/building-images/#recommended-best-practices)).

## CloudFlare Access & Restricting Traffic
You can block all external traffic to your site, and only allow traffic originating from Cloudflare. This offers a number advantages for Cloudflare enabled sites:

* Ensure malicious users are not bypassing Cloudflare's WAF
* When paired with [Cloudflare access](https://teams.cloudflare.com/access){: target="_blank" }, provide a safe way of blocking access to unauthenticated users.
* Ensure users are not bypassing your Cloudflare cache and increasing your bandwidth costs
