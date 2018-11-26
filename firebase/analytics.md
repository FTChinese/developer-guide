## Events and Params Used in Android/iOS Apps

### App Open

#### `APP_OPEN` Event

Android: When user opend or returned to the app. It is called in the `MainActivity`'s `onResume` method. It might record much more times than "cold launch".

iOS: App Open event. By logging this event when an App becomes active, developers can understand how often users leave and return during the course of a Session. Although Sessions are automatically reported, this event can provide further clarification around the continuous engagement of app-users.
static NSString *const kFIREventAppOpen NS_SWIFT_NAME(AnalyticsEventAppOpen) = @"app_open";

Parameters:

* `SUCCESS` Its value is an ISO8601 date time string in device's local zone: `2018-11-26T14:22:20+08:00`.

### Reading

#### `SELECT_CONTENT` Event

Android: The moment user clicked an item in a list of articles in any of channel page.

iOS: Select Content event. This general purpose event signifies that a user has selected some content of a certain type in an app. The content can be any object in your app. This event can help you identify popular content and categories of content in your app. 

在FT中文网的项目中，从列表页（比如首页、频道页）点击某条内容，会触发此事件。而内容真正展现的时候，会触发View Item事件。
static NSString *const kFIREventSelectContent NS_SWIFT_NAME(AnalyticsEventSelectContent) = @"select_content";

* `CONTENT_TYPE` Its value is `story | premium | video | interactive | column` ...
* `ITEM_ID` is the id of an article or channel, etc..


#### `VIEW_ITEM` Event

Android: When an article is fully loaded.

iOS: This event signifies that some content was shown to the user. This content may be a product, a webpage or just a simple image or text. Use the appropriate parameters to contextualize the event. Use this event to discover the most popular items viewed in your app. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately. In iOS app, this is triggered in viewWillAppear of content detail view controllers such as story, interactive and radio. 

在FT中文网的项目中，详情页展现会触发此事件。
static NSString *const kFIREventViewItem NS_SWIFT_NAME(AnalyticsEventViewItem) = @"view_item";

* `ITEM_ID` the id of an article or channel.
* `ITEM_NAME` The title of an article
* `ITEM_CATEGORY` `story, premium, video ...` (or use `CONTENT_TYPE`?)


#### `VIEW_ITEM_List`
Log this event when the user has been presented with a list of items of a certain category. In iOS, this is trigger in viewWillAppear of Content List View Controllers such as home, china, daily English, etc... 

static NSString *const kFIREventViewItemList NS_SWIFT_NAME(AnalyticsEventViewItemList) = @"view_item_list";


#### `SHARE`

Apps with social features can log the Share event to identify the most viral content. 
static NSString *const kFIREventShare NS_SWIFT_NAME(AnalyticsEventShare) = @"share";

* `CONTENT_TYPE` story, video ...
* `ITEM_ID` the id of an article
* `METHOD` used only for wechat share. Its a constant `wechat`.

### Subscription and Payment

#### Pay Wall Displayed Event
When the pay wall is displayed to the user as a result of tapping on a paid content. Parameter: pay_wall_source

#### Subscription Page Displayed Event
When the user visit the subscription page. Parameter: pay_wall_source?


#### `ADD_TO_CHART` Event

The moment user opens this screen:

![Payment Activity](payment.png)

In iOS app, there's no such step as in-app-purchase will only charge from Apple app store. So it will directly go to AnalyticsEventBeginCheckout. 

Parameters used for this event:

* `ITEM_ID`. Its value is the combination of membership's tiers and billing cycles.

`member_tier` is an enum: `standard`, `premium`.
`billing_cycle` is an enum: `year`, `month`.

The combination will produce values for `ITEM_ID`: `standard_year`, `standard_month`, `premium_year`.

* `ITEM_NAME`. Its value is one of `member_tier`'s value.

* `ITEM_CATEGORY`. Its value is one of `billing_cycle`.

* `QUANTITY` Its value is a constant `1`.

pay_wall_source

#### `BEGIN_CHECKOUT` Event

Android and iOS: When user selected a pyament method and clicked "支付" button in the above screenshot.

Parameters used for this event:

* `VALUE` Its value is a double, indicating the amount charged to a user. This value is set by Subscription API and received by client together with parameters used to call wechat pay and alipay.

Response of Subscription API for wechat pay:
```json
{
    "ftcOrderId": "",
    "price": 198.00,
    "appid": "",
    "partnerid": "",
    "prepayid": "",
    "package": "",
    "noncestr": "",
    "timestamp": "",
    "sign": ""
}
```

For Alipay:
```json
{
    "ftcOrderId": "",
    "price": 198.00,
    "param": ""
}
```
Provided to client app to know which order to query later.

The fields `ftcOrderId` and `price` are included in the response of both payment methods. They are provided by the API to client app to know the details of the order. They are not used by any of the payment SDK. Other fields are used to call SDK of respective payment method.

The value of `price`is used as the value of `VALUE` param.

Howerver, current version of Subscription API (as of 2018-11-26) has not implemented the `price` field yet. Client app might get `0.0`.

* `CURRENCY` is a constant string `CNY`.

* `METHOD` Its value is an enum correspondig to our database definition of `payment_method`: `alipay` for Zhifubao, `tenpay` for Wechat, and `stripe` for Stripe.

pay_wall_source

#### `ECOMMERCE_PURCHASE` Event

This event signifies that an item was purchased by a user. Note: This is different from the in-app purchase event, which is reported automatically for App Store-based apps. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately. 
目前FT中文网的项目中有两种购买，一种是订阅，另一种是电子书(目前之后iOS有电子书)。两种购买都会触发这个事件。我们有可能需要为订阅创建定制的事件。
static NSString *const kFIREventEcommercePurchase NS_SWIFT_NAME(AnalyticsEventEcommercePurchase) = @"ecommerce_purchase";

Parameters:

* `CURRENTCY` is `CNY`
* `VALUE` is the same as in `CHECKOUT_EVENT`
* `METHOD` is the same as in `CHECKOUT_EVENT`
pay_wall_source

#### Present Offer event
This event signifies that the app has presented a purchase offer to a user. Add this event to a funnel with the kFIREventAddToCart and kFIREventEcommercePurchase to gauge your conversion process. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately. 
在FT中文网项目中，这个事件用来记录某个订阅产品的信息展现。
static NSString *const kFIREventPresentOffer NS_SWIFT_NAME(AnalyticsEventPresentOffer) = @"present_offer";


### Login

#### `LOGIN` Event
Apps with a login feature can report this event to signify that a user has logged in.
static NSString *const kFIREventLogin NS_SWIFT_NAME(AnalyticsEventLogin) = @"login";

Parameters:

* `METHOD` Its value is `email` currently. Later `wechat` will be added when API supports wechat login.

### Signup

#### `SIGN_UP` Event
This event indicates that a user has signed up for an account in your app. The parameter signifies the method by which the user signed up. Use this event to understand the different behaviors between logged in and logged out users. 
static NSString *const kFIREventSignUp NS_SWIFT_NAME(AnalyticsEventSignUp) = @"sign_up";

Parameters:

* `METHOD` save as the one used in `LOGIN` event.

### Search

#### Search
Android: Not implemented in Android yet.

iOS: Apps that support search features can use this event to contextualize search operations by supplying the appropriate, corresponding parameters. This event can help you identify the most popular content in your app. Use this to understand user and send relevant content if his need is not satisfied. Should avoid sending spam after a long period of time. 
static NSString *const kFIREventSearch NS_SWIFT_NAME(AnalyticsEventSearch) = @"search";

#### View Search Result
Log this event when the user has been presented with the results of a search. 
static NSString *const kFIREventViewSearchResults NS_SWIFT_NAME(AnalyticsEventViewSearchResults) = @"view_search_results";


### App Launch

This uses custom event names:
```kotlin
// when a user clicks an ad.
const val AD_CLICK = "ftc_ad_click"
// when an ad is shown to user without being manually skipped.
const val AD_VIEWED = "ftc_ad_viewed"
// When a user skips an ad.
const val AD_SKIP = "ftc_ad_skip"
```
#### `AD_SKIP` Event

When user clicked the skip button. If a user do nothing and let the ad play to end, it doesn't trigger this event. 

NOTE: Android used a count down timer button, rather than a simple close button.

No parameters set.

#### `AD_CLICK`

When user clicked the ad and a browser is opend to show the ad.

A clicked ad is terminated immediately (meaning timer stops) while the browser opens the link to the ad.

#### `AD_VIEWED`
When an ad is displayed to the user. 

## User Properties
### UserType
User types: VIP, Subscriber, Free Member, Visitor
### EngagementScore
Engagement based on frequency, recency and volume
### PendingRenewal
iOS only

