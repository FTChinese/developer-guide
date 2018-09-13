## Appendix

### 1. Generate code verifier and code challege in various languages

#### 1.1 Golang
Golang provides standard approaches to handle base64url and base64 encoding.

```go
// See https://golang.org/pkg/crypto/rand/#Read
func randomBytes(len int) ([]byte, error) {
	b := make([]byte, len)

	_, err := rand.Read(b)

	if err != nil {
		return nil, err
	}

	return b, nil
}

// See https://golang.org/pkg/encoding/base64/#pkg-variables
func codeVerifier(b []byte) string {
	return base64.RawURLEncoding.EncodeToString(b)
}

// See https://golang.org/pkg/crypto/sha256/#Sum256
func codeChallenge(s string) string {
	sum := sha256.Sum256([]byte(s))

	return base64.RawURLEncoding.EncodeToString(sum[:])
}
```

#### 1.2 Node.js
Node standard library only handles base64 encoding. You have to implement base64url yourself.

base64url.js
```js
/**
 * @description Turn base64url encoded string to base64 encoded string.
 * @param {string} str
 * @return {string}
 */
function unescape (str) {
  return (str + '==='.slice((str.length + 3) % 4))
    .replace(/-/g, '+')
    .replace(/_/g, '/')
}

/**
 * @description Turn base64 encoded string to base64url encoded string
 * @param {string} str
 * @return {string}
 */
function escape (str) {
  return str.replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=/g, '')
}

/**
 * @description base64url encode a buffer
 * @param {Buffer} buf
 * @return {string}
 */
function encode (buf) {
  return escape(buf.toString('base64'))
}

/**
 * @description Turn base64url encoded string back or original buffer
 * @param {string} str - base64url encoded string
 * @return {Buffer}
 */
function decode (str) {
  return Buffer.from(unescape(str), 'base64')
}
```

Generate code verfier and code challenge
```js
const crypto = require('crypto');
const util = require('util');
const randomBytes = util.promisify(crypto.randomBytes);

async function codeVerifier () {
  const buf = await randomBytes(32);

  return base64url.encode(buf);
}

function codeChallege (verifier) {
  const buf = crypto.createHash('sha256')
    .update(verifier)
    .digest();

  return base64url.encode(buf);
}
```

#### 1.3 Swift

#### 1.4 Java

#### 1.5 Kotlin

#### 1.6 PHP

### 2 References

* [The OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749)
* [Proof Key for Code Exchange by OAuth Public Clients](https://tools.ietf.org/html/rfc7636)
* [The Base16, Base32, and Base64 Data Encodings](https://tools.ietf.org/html/rfc4648)
* [OAuth 2.0 Servers](https://www.oauth.com/)
