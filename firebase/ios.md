## Predefined Events Used in iOS


### App Open
App Open event. By logging this event when an App becomes active, developers can understand how often users leave and return during the course of a Session. Although Sessions are automatically reported, this event can provide further clarification around the continuous engagement of app-users.
static NSString *const kFIREventAppOpen NS_SWIFT_NAME(AnalyticsEventAppOpen) = @"app_open";


### Select Content
Select Content event. This general purpose event signifies that a user has selected some content of a certain type in an app. The content can be any object in your app. This event can help you identify popular content and categories of content in your app. 

在FT中文网的项目中，从列表页（比如首页、频道页）点击某条内容，会触发此事件。而内容真正展现的时候，会触发View Item事件。
static NSString *const kFIREventSelectContent NS_SWIFT_NAME(AnalyticsEventSelectContent) = @"select_content";

### View Item event
This event signifies that some content was shown to the user. This content may be a product, a webpage or just a simple image or text. Use the appropriate parameters to contextualize the event. Use this event to discover the most popular items viewed in your app. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately.
在FT中文网的项目中，详情页展现会触发此事件。
static NSString *const kFIREventViewItem NS_SWIFT_NAME(AnalyticsEventViewItem) = @"view_item";

### Share event
Apps with social features can log the Share event to identify the most viral content. 
static NSString *const kFIREventShare NS_SWIFT_NAME(AnalyticsEventShare) = @"share";

### E-Commerce Purchase event
This event signifies that an item was purchased by a user. Note: This is different from the in-app purchase event, which is reported automatically for App Store-based apps. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately. 
目前FT中文网的项目中有两种购买，一种是订阅，另一种是电子书。两种购买都会触发这个事件。我们有可能需要为订阅创建定制的事件。
static NSString *const kFIREventEcommercePurchase NS_SWIFT_NAME(AnalyticsEventEcommercePurchase) = @"ecommerce_purchase";

### Login event
Apps with a login feature can report this event to signify that a user has logged in.
static NSString *const kFIREventLogin NS_SWIFT_NAME(AnalyticsEventLogin) = @"login";


### Sign Up event. 
This event indicates that a user has signed up for an account in your app. The parameter signifies the method by which the user signed up. Use this event to understand the different behaviors between logged in and logged out users. 
static NSString *const kFIREventSignUp NS_SWIFT_NAME(AnalyticsEventSignUp) = @"sign_up";


### Search event. 
Apps that support search features can use this event to contextualize search operations by supplying the appropriate, corresponding parameters. This event can help you identify the most popular content in your app. Use this to understand user and send relevant content if his need is not satisfied. Should avoid sending spam after a long period of time. 
static NSString *const kFIREventSearch NS_SWIFT_NAME(AnalyticsEventSearch) = @"search";


### View Search Results event
Log this event when the user has been presented with the results of a search. 
static NSString *const kFIREventViewSearchResults NS_SWIFT_NAME(AnalyticsEventViewSearchResults) = @"view_search_results";


### View Item List event
Log this event when the user has been presented with a list of items of a certain category. 
static NSString *const kFIREventViewItemList NS_SWIFT_NAME(AnalyticsEventViewItemList) = @"view_item_list";


### Present Offer event
This event signifies that the app has presented a purchase offer to a user. Add this event to a funnel with the kFIREventAddToCart and kFIREventEcommercePurchase to gauge your conversion process. Note: If you supply the @c kFIRParameterValue parameter, you must also supply the @c kFIRParameterCurrency parameter so that revenue metrics can be computed accurately. 
在FT中文网项目中，这个事件用来记录某个订阅产品的信息展现。
static NSString *const kFIREventPresentOffer NS_SWIFT_NAME(AnalyticsEventPresentOffer) = @"present_offer";