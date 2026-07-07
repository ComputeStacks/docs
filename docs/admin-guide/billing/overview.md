# Billing: Overview

ComputeStacks is a metered (post-pay) system, which means all of our resources are either shown as *per-hour*, or *per-unit*.

We perform all billing calculation based on a user's assigned [billing plan](plans.md), and report that to your [billing system](invoicing-and-payments.md).

## Usage Calculation

ComputeStacks uses a simple realtime price strategy for recording billable usage for consumed resources. This is in contrast to more traditional billing systems which determine pricing at the time an invoice is generated, not when the resource was consumed.

Each hour, ComputeStacks pulls the current usage across all subscriptions. At the same time, it performs a real time price lookup based on the rules defined in their billing plan.

Because the price is determined in real time and stored alongside the quantity used, any change you make in the future will not adjust their previously stored usage.
