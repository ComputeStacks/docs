---
title: Billing Plans
description: Billing Plans
---
# Billing Plans
ComputeStacks uses billing plans as a rule set for determining the real time price for a given resource. We also use this for generating the price matrix on order forms. 

You can create as many billing plans as you want, but only one may the default. This is useful for creating custom or special pricing for a different set of users.

!!! danger ""
    If no price rule exists for a given scenario _(e.g. currency + region + quantity)_, ComputeStacks will default to a price of 0.00.

[ ![Billing Plan Overview](/images/content/billing/billing-plan-overview.png){: style="border: 1px solid #ccc;padding:5px;width:100%;" } ](/images/content/billing/billing-plan-overview.png){: target="_blank" }

## Products & Packages

A product is a separate object from Billing Plans, which allow you to define it once, and use it in multiple plans. 

### Creating a Product

Products are the base for packages, so you must define this first prior to creating a package.

* **External ID**

    This is available in [WebHooks](../../getting_started/integrations/webhooks.md) and API Calls. This is generally used by billing integrations to identify this product.

* **Package or Metered Resource**:
    * **Package:** Container package
    * **Metered Resource:** Bandwidth, Storage.
* **Resource**

    Only applies of 'Kind' is 'Metered Resource'
    This tells ComputeStacks what kind of resource this is. When we're calculating pricing on the hour, we will use this value to find the price for a given resource.
* **Unit**

    This should almost always be 1.

* **Unit Type**

    `CORE` for `CPU`, `MB` for Memory, and `GB` for bandwidth and storage.

### Package Settings

After creating a product, and selecting _Package_ as the product kind, you will have the ability to customize the package resource.

* **CPU**
    
    How many CPU Cores to assign. These can be fractional units of `0.25`.

* **Memory**
    
    Memory is stored in `MB`.

* **Volume Storage**
    
    Anything over this amount will be charged at the current storage rate set in the users billing plan.

* **Temporary Disk**

    Temporary disk is all storage used by the container, less any volume usage. Anything over this amount will be charged at the current temporary disk rate set in the users billing plan.

* **Bandwidth**
    
    Up to this amount is included, anything else will be charged as overage.

* **Backup Storage**

    Anything beyond this will be charged as overage.

## Billing Phases

Phases are a way to describe the current state of a subscription. There are three possibilities: Trial, Discount, and Final. 

Phases only move forward and never backwards. The transition to the next phase is automatic and based on the duration of that phase.

The duration defined in the phase is the *maximum* amount of time the subscription will stay in the phase. The actual time frame will depend on the `billing_start` field for a given user. The *billing start* is automatically set when a user places their first order. This can also be set manually by an administrator at any time.

For example, if a trial phase is set to last for *14 days* and a user placed their first subscription for a different order 7 days ago, they will get a free trial for 7 more days.

So for Trial and Discount phases, the time frame not only applies to how long a given subscription will be in that phase, but also the total amount of time they have access to that phase.

## Pricing

Prices are unique to their parent phase, and can be customized for specific regions, currencies, and quantity. 

!!! tip ""
    There is a global default currency set during the installation process, however each user can have a different currency set by Administrators. This, along with billing plans, offers the ability to support multiple currencies under the same installation.

### Tiers

By adding a `maximum allowed quantity`, you can create tiered pricing. This is popular for storage and bandwidth.