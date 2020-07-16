---
title: Redis
description: Redis Guide
---
# Redis Guide
Redis is a very fast, lightweight, single-threaded key-value store. While it's typically used as an in-memory cache, it's also capable of acting as a persistent data store for your application.

Within the ComputeStacks environment, the default configuration makes a few opinionated decisions on your behalf, however it's easy to create your own custom redis image for your unique situation.

## Key Features of the default Redis Configuration

* In-memory only, no disk snapshots
* Password protected
* TLS encryption when connecting to redis externally _(outside the project)_
  * The most common use case for this is when using our cPanel integration and you want to add redis to a site hosted on cpanel.

    !!! danger ""
        In order to use TLS with PHP, you must be using php `v7.2+`, and [phpredis](https://github.com/phpredis/phpredis){: target="_blank" } `v5.0+`.

## Connecting to Redis

### Inside the project

Connecting to redis from an application inside the same project will work just like normal. Simply enter the private IP address of the redis container, add the authentication password, and connect. The port will be the default `6379`. 

### External Connections

Connecting from outside your redis project will require a few additional steps. Depending on your providers setup, you may already have your redis container exposed to the world. To verify that, navigate to your redis service and look at the ingress rules. 

You want to see a number under **Public Port**, and the protocol should be `tcp+tls -> tcp`. The protocol just means that the global load balancer is performing tls termination for you, and passing the un-encrypted tcp connection back to redis _(redis does not natively support tls)_. 

If you don't have a public port, or the protocol does not say `tls`, you will want to edit the ingress rule and perform the following steps:

1. Check _Enable External Access?_
2. Set the _Protocol_ to `TCP+TLS`.

#### View Public Connection Details

##### Controller Example

![Redis Ingress Rule](/images/content/container-images/redis/redis-ingress-rule.png)


##### cPanel Example

![Redis Service Overview](/images/content/container-images/redis/ei-redis-service-overview.png)

#### Connecting Your Application

In your application, you will want to use the following URL in your app: `tls://<my-domain>`. If your application requires the port be included in the URI string, then you can add `:<public-port>` to that.

You will also want to add the redis password provided by ComputeStacks.

??? example "Example PHP connection"

    ```php
    <?php
    echo "<h1>Redis Test Connection</h1>";
    echo '<strong>Current PHP version: ' . phpversion() . "</strong>";
    echo "<hr>";
    echo "Connection Result: ";
    $redis = new Redis();
    $redis->connect('tls://url', port);
    $redis->auth('password');
    echo $redis->ping("It works!");
    ```

## Video Demos

??? info "(VIDEO) Adding Redis to cPanel"
    <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/AwuC6M4rl1o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

??? info "(VIDEO) Adding Redis to Wordpress"
    <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/tQ_qll_gntc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>