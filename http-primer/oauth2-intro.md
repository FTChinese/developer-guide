## 1. Intro
OAuth的目的：把资源所有者的受保护的资源分享给第三方应用使用。

### 角色
* 资源所有者
* 资源服务器
* 客户端
* 授权服务器

### 1.1 Authorization Grant

四种授权许可（authorization grant）：
* Authorization code
* Implicit
* Resource owner password credentials
* Client credentials

## 2. 客户端注册

采用OAuth 2.0协议之前， 客户端需要首先在授权服务器注册。客户端开发者应该：

* 指明客户端的类型
* 提供回调URI
* 授权服务器要求的其他信息：应用名称、网址、描述、logo、法律条款等。

### 2.1 客户端类型（Client Types）

按照能否安全验证分为两类：

* 保密。客户端能够保证其凭证不外泄。（如客户端运行在安全的服务器上，其凭证不会轻易被他人获取）。

* 公开。客户端无法未凭证保密。（客户端在资源所有者的设备四行运行，如原生应用、以及基于浏览器的应用）。

OAuth 2.0规范的Client Profiles

* Web application. 保密客户端，运行在服务器上。
* User-agent-based application. 公开客户端，运行在浏览器中等。
* Native application. 公开客户端。运行在所有者的设备上。

## 3. Protocol Endpoints

* Authorization endpoint.
* Token endpoint.

### 3.1 Authorization Endpoint

授权服务器必须首先验证资源所有者的身份。

向授权地址发起请求时，用明文方式传递用户凭据，因此要求必须使用TLS。

授权服务器必须忽略请求没有值的参数，必须忽略无法识别的请求参数。同一个参数在请求和响应中不能出现多次。

## 4. 获取授权

### 4.1 Authorizaiton Code Grant

用户获取access token和refresh token。用户保密客户端。工作流程基于重定向，因此客户端必须能够与资源所有者的用户代理（通常时浏览器）交互，能够接受授权服务器通过重定向发来的请求。

#### 4.1.1 授权请求

使用`application/x-www-form-urlencoded`方式在授权地址后加上如下参数：

* `response_type=code` Required
* `client_id={your-client-id}` Required.
* `redirect_uri={uri}` Optional.
* `scope={...}` Optional
* `state={...}` Recommened.用户防止跨站请求欺诈。授权服务器会原样返回，供客户端验证此次请求正确。这是一串随机字符。推荐使用[密码学安全伪随机数生成器](https://en.wikipedia.org/wiki/Cryptographically_secure_pseudorandom_number_generator)，转成十六进制字符串或者base64url编码的字符串。

例如，客户端让用户代理发出以下请求：
```
GET /authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb HTTP/1.1
Host: server.example.com
```

授权服务器验证请求，保证所有参数存在并且有效：验证`client_id`存在并且有效，`redirect_uri`与注册时填写的一致。

通过验证后，授权服务器把客户端重定向到注册时填写的`redirect_uri`。

#### 4.1.2 授权响应

如果资源所有者批准了访问请求，授权服务器生成authorization code，通过重定向的方式告知客户端，在`redirect_uri`上加入以下参数：

* `code` 授权服务器生成的authorization code。授权码必须在短时间内失效。推荐最长有效期10分钟。一个授权码只允许客户端使用一次(SQL数据库实现中应包含创建时间、过期时间、使用使用过字段。Redis支持自动过期删除)。否则，授权服务器必须拒绝请求。

* `state` 客户端最初发过去的`state`参数。

示例：
```
HTTP/1.1 302 Found
Location: https://client.example.com/cb?code=SplxlOBeZQQYbYS6WxSbIA&state=xyz
```

客户端必须忽略不能识别的响应参数。

注：`redirect_uri`是一个关键的安全机制。假设你把`client_id`打包进了iOS安装包中，但二进制文件是可以反编译的，通过反编译，别人拿到你的`client_id`，然后用`client_id`向授权服务器发起请求，通过重定向机制，授权服务器把请求重定向到你预先填写的URL中，这样欺诈方无论如何都收不到授权码。假如不是采用重定向机制，而是简单HTTP请求-响应流程，那么任何人获取了你的`client_id`，都可以假装成你来骗取服务器信任。

#### 4.1.3 错误响应

错误原因：
* `redirect_uri` 缺失、无效、不匹配；
* `client_id` 缺失、无效

参数：

* `error` Required. One of
  * `invalid_request` Missing a requried parameter, includes an invalid paramter value, includes a parameter more than once, or is otherwise malformed.

  * `unauthorized_client` The client is not authorized to reuqest an authorization code using this method.

  * `access_denied`

  * `unsupported_response_type`

  * `invalid_scope`

  * `server_error`

  * `temporarily_unavailable`

* `error_description` Optional

* `error_uri` Optional

* `state` Requried is a `state` parameter was present in the client authorization request.

#### 4.1.4 Access Token请求

* `grant_type=authorization_code` Required.
* `code` 从授权服务器收到的授权码。
* `redirect_uri` Required if `redirect_uri` was included in the authorization request.
* `client_id` Requried if the client is not authenticating with the authorization server.

如果客户端的类型时保密的，或者客户端在注册时给予了客户端凭据，客户端必须向授权服务器验证：

```
POST /token HTTP/1.1
Host: server.example.com
Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA
&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb
```

#### 4.1.5 Access Token Response

Example successful response:
`200 OK`
`Cach-Control: no-store`
`Pragma: no-cache`
```json
{
  "access_token": "",
  "token_type": "example",
  "expires_in": 3600,
  "refresh_token": ""
}
```

### 4.2 Implicit grant

### 4.3 Resource Owner Password Credentials

### 4.4 Client Credentials Grant

客户端请求的资源在自己的控制下，可以仅使用客户端凭据请求access token。

#### 4.4.1 Access Token请求
客户端向token地址发起POST请求，包含如下字段：

* `grant_type=client_credentials` Required.
* `scope` Opitonal

```
POST /token
Authorization: Basic base64(client_id:client_secret)
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
```

#### 4.4.2 Access Token响应

不能包含`refresh_token`。

## 5. 颁发Access Token

### 5.1 成功响应

采用`application/json`媒体类型。包含字段：

* `access_token` Requried
* `token_type` Requried
* `expires_in` Recommended
* `refresh_token` Optional
* `scope` Opitonal

Header filed must contain `Cach-Control: no-store` and `Pragma: no-cache`.
```json
HTTP/1.1 200 OK
Content-Type: application/json;charset=UTF-8
Cache-Control: no-store
Pragma: no-cache

{
  "access_token":"2YotnFZFEjr1zCsicMWpAA",
  "token_type":"example",
  "expires_in":3600,
  "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
  "example_parameter":"example_value"
}
```

### 5.2 错误响应

* `error` Requried.
  * `invalid_request` The request is missing a requried parameter, including an unsupported parameter value, repeats a paameter, include mulltiple credentials.
  * `invalid_client`: unknow client, no client authentication included, or unsupported authentication method.
  * `invalid_grant`
  * `unauthorized_client` The client is not authorized to use this authorization grant type.
  * `unsupported_grant_type`
  * `invalid_scope`
* `error_description`
* `error_uri`

## 7. 访问受保护的资源

### 7.1 Access Token类型

* `bearer` This type of token is simply included in request `Authorization` header:
```
Authorization: Bearer access-token-string
```

* `mac`

## 9. 原生应用

原生应用采用Authorization Code流程。原生应用注册时只给`client_id`, 不给`client_secret`。因为标准OAuth 2.0必须要与浏览器交互，因此原生应用可供使用的选择是：打开系统浏览器；原生应用注册自定义重定向URL。

### 9.1 PKCE

[Proof Key for Code Exchange by OAuth Public Clients](https://tools.ietf.org/html/rfc7636)

#### 9.1.1 客户端创建`code_verifier`

客户端首先为每一个请求创建一个coder verifier。coder verifier是一个字符串，最小长度43，最大长度128，使用加密学随机字符串生成，字符范围`[A-Z][a-z][0-9]-._~`。

建议：使用加密学随机数字生成器创建32个8位字节(32 random bytes)，然后对这些字节进行base64url编码（注意：不是base64编码！）生成43个字符构成的安全URL字符串。

```
code_verifier = Base64url-encode(random-bytes(32))
```

Base64url与Base64编码的区别参考这里：[The Base16, Base32, and Base64 Data Encodings](https://tools.ietf.org/html/rfc4648)

#### 9.1.2 客户端创建`code_challenge`

然后，客户端变换`code_verifier`，生成`code_challenge`：
```
code_challenge = Base64url-encode(SHA256(code_verifier))
```

#### 9.1.3 客户端的发起授权请求

* `response_type=code`
* `client_id`
* `redirect_uri`
* `state`
* `code_chanllege` Requried
* `code_chanllege_method=S256` Optional. 如果请求参数中没有这一项，默认`plain`。我们的实现不支持`plain`，默认只有`S256`，所以我们不加这个参数。

#### 9.1.4 服务器返回授权码

服务器端生成授权码时，必须把`code_challenge`、`code_challenge_method`同授权码关联起来，以备稍后使用。

#### 9.1.5 错误响应

如果客户端请求中没有包含`code_challege`，错误响应中必须有`error=invalid_request`。

#### 9.1.6 客户端发送授权码和Coder Verifier到Token地址

收到授权码后，客户端向Token地址发起POST请求Access Token。除Authorization Code Grant规定的参数之外，还要包含`code_verifier`

* `grant_type=authorization_code` Required.
* `code` 从授权服务器收到的授权码。
* `redirect_uri` Required if `redirect_uri` was included in the authorization request.
* `client_id` Requried.
* `code_verifier` Required.

#### 9.1.6 服务器返回Token之前验证`code_verifier`

服务器收到请求后，计算`code_verifier`的SHA256值，与此前存储的`code_challege`对比。如果两个值相等，返回Access Token。如果不想等，返回`error=invalid_grant`。
