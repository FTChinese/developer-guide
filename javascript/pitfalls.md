## Scoping

### Switch

If you write code in this way, you will get error like `SyntaxError: Identifier 'resp' has already been declared`.

```js
async fetchAccount() {
    switch (this.account.loginMethod) {
        case "email": 
            const resp = await request
                .get(nextApi.account)
                .set(KEY_USER_ID, this.account.id);

            /**
             * @type {IAccount}
             */
            const acnt = resp.body;
            this.account = acnt;
            this.member = new Membership(acnt.membership);
            break;

        case "wechat":
            const resp = await request
              .get(nextApi.wxAccount)
              .set(KEY_UNION_ID, this.account.unionId);

            /**
             * @type {IAccount}
             */
            const acnt = resp.body;
            this.account = acnt;
            this.member = new Membership(account.membership);
            break;

        default:
            throw new Error("Unknown login method.");
    }
 }
```

`case` does not create a new scope. You should do it this way:

```js
async fetchAccount() {
    switch (this.account.loginMethod) {
        case "email": {
            const resp = await request
                .get(nextApi.account)
                .set(KEY_USER_ID, this.account.id);

            /**
             * @type {IAccount}
             */
            const acnt = resp.body;
            this.account = acnt;
            this.member = new Membership(acnt.membership);
        } break;

        case "wechat": {
            const resp = await request
              .get(nextApi.wxAccount)
              .set(KEY_UNION_ID, this.account.unionId);

            /**
             * @type {IAccount}
             */
            const acnt = resp.body;
            this.account = acnt;
            this.member = new Membership(account.membership);
        } break;

        default:
            throw new Error("Unknown login method.");
    }
 }
```

See [Use Curly Braces with ES6 Let and Const in Switch Blocks](https://medium.com/@e_himmelfarb/use-curly-braces-with-es6-let-and-const-in-switch-blocks-react-redux-reducers-c0b01b37d748)