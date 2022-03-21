---
title: ElasticSearch
description: ElasticSearch Guide
---
# ElasticSearch with Wordpress
This guide specifically covers integrating ElasticSearch for Wordpress, however many of the procedures can be applied to any existing application.

Our ElasticSearch implementation was specifically designed to work with Wordpress, [ElasticPress](https://github.com/10up/ElasticPress){: target="_blank" }, and include support for auto-suggesting search results. We run nginx as a secure frontend for our ElasticSearch service in order to provide both password authentication, and secure read-only access for auto-suggest results.

## Installation

Installation of ElasticSearch is as easy and choosing the service during the order process in ComputeStacks. All of the initial configuration will be handled automatically. 

## Configure Wordpress

Install ElasticPress from the plugin section in `wp-admin` and activate it. Skip past the hosted options and choose _self host_ and enter your ElasticSearch details. _(Replace `[password]` with your elastic search password)_

If you're using our full standalone controller, then you will need to find the password from your service overview page and manually type in the url:

```
https://admin:[password]@[your-url]
```

The last step is to setup auto-suggest (optional). The first thing you will need to do is find the name of your elastic search index. This is dynamically generated based on the domain name of your wordpress site, so you will need to update this if you ever change your url.

Under ElasticPress, click _Index Health_. Listed in the upper left-hand corner will be your index name.

Now, navigate to Settings in ElasticPress and expand the auto-suggest section and enable auto-suggest, and add your URL, which will be in the form of:

```
https://your-url/autosuggest/[indexName]
```
