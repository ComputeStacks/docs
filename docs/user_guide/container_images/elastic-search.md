---
title: ElasticSearch
description: ElasticSearch Guide
---
# ElasticSearch with Wordpress
This guide specifically covers integrating ElasticSearch for Wordpress, however many of the procedures can be applied to any existing application.

Our ElasticSearch implementation was specifically designed to work with Wordpress, [ElasticPress](https://github.com/10up/ElasticPress){: target="_blank" }, and include support for auto-suggesting search results. We run nginx as a secure frontend for our ElasticSearch service in order to provide both password authentication, and secure read-only access for auto-suggest results.

## Installation

Installation of ElasticSearch is as easy and choosing the service during the order process in ComputeStacks. All of the initial configuration will be handled automatically. 

??? tip "Installation Video on cPanel"
    <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/i8fxHr4uKa8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Configure Wordpress

Install ElasticPress from the plugin section in `wp-admin` and activate it. Skip past the hosted options and choose _self host_ and enter your ElasticSearch details. If you're using the ComputeStacks cPanel interface, the full URL including authentication details can be copy-pasted from the control panel. _(Replace `[password]` with your elastic search password)_

If you're using our full standalone controller, then you will need to find the password from your service overview page and manually type in the url:

```
https://admin:[password]@[your-url]
```

The last step is to setup auto-suggest (optional). The first thing you will need to do is find the name of your elastic search index. This is dynamically generated based on the domain name of your wordpress site, so you will need to update this if you ever change your url.

Under ElasticPress, click _Index Health_. Listed in the upper left-hand corner will be your index name.

Now, navigate to Settings in ElasticPress and expand the auto-suggest section and enable auto-suggest, and add your URL, which will be in the form of:

!!! note ""
    If you're using our cPanel interface, the autosuggest url is also available there to copy/paste.

```
https://your-url/autosuggest/[indexName]
```

??? tip "Adding ElasticSearch to Wordpress Video"
    <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/amAwwH9B9Ng" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
