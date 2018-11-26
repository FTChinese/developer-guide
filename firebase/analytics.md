## Android

### Events and Params Used in Android Version 1.1.0

#### Subscription and Payment

The moment user opens this screen:

![Payment Activity]("payment.png")

`ADD_TO_CHART` event is triggered.

Parameters used for this event:

* `ITEM_ID`. Its value is the combination of membership's tiers and billing cycles.

`member_tier` is an enum: `standard`, `premium`
`billing_cycle` is an enum: `year`, `month`

