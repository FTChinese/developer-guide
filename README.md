# FTChinese Programming Guide

## Golang

### Dependency Management

Use `dep`

### Handle `golang.org` Packages

Due to network issues you cannot use `go get` to download packages from `golang.org` which, unfortunately, might be used by third-party packages you imported. Enabling VPN in your terminal is definitely the best way out.

You can also manually create `golang.org/x` directory under `$GOPATH/src`, and clone those repos from github:

* `golang.org/x/crypto` -> `https://github.com/golang/crypto.git`

* `golang.org/x/image` -> `https://github.com/golang/image.git`

* `golang.org/x/mobile` -> `https://github.com/golang/mobile.git`

* `golang.org/x/net` -> `https://github.com/golang/net.git`

* `golang.org/x/sys` -> `https://github.com/golang/sys.git`

* `golang.org/x/text` -> `https://github.com/golang/text.git`

* `golang.org/x/tools` -> `https://github.com/golang/tools.git`

## Node.js

Use ESDoc wherever you write codes

## PHP

PHP is not that bad if you follow the principles of **Modern PHP**.