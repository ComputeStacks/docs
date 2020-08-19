---
title: "How To: Free Trials"
description: Creating Free Trials
---
# Creating Free Trials & Discount Phases

## Overview

ComputeStacks supports both free trials, and discount periods for all services in a billing plan.

Given the following billing plan, we have a free trial for 7 days, and then a 3 month discounted price.

[ ![Billing Plan Item](/images/content/billing/billing-plan-item.png){: style="border: 1px solid #ccc;padding:5px;width:100%;" } ](/images/content/billing/billing-plan-item.png){: target="_blank" }

When viewing on the order form, the customer will see all 3 pricing phases so they know exactly what they will pay, and when.

[ ![Free Trial on Order Form](/images/content/billing/order-form-package-with-phase.png){: style="border: 1px solid #ccc;padding:5px;width:50%;" } ](/images/content/billing/order-form-package-with-phase.png){: target="_blank" }

## Calculating The Start Date

Both _Free Trials_ and _Discount Phases_ will only apply to **new customers**. To make this available to an _existing customer_, or to extend their free trial and discount periods, you can manually edit the user and change the date of the field `Billing Start`.

The `Billing Start` field will be blank for new signups, and will only be set upon their first order. This means that if a user signs up on August 1st but does not order anything, on December 1st they will still have the free trial and discount periods available.

## Creating A Pricing Period

1. Navigate to the billing plan and click **Add Phase** next to the product. 
2. Select either **Free Trial** or **Discount**.
3. Duration is how long the subscription will stay in that period. We support hours, days, months, and years.

After the duration has passed, the subscription will automatically move to the next phase. This may be either a discount phase (if coming from a free trial), or the final phase.