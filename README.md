# Style Guide and Pitfalls

* [MySQL](./mysql.md)
* [Node.js](./node.md)
* [PHP](./php.md)
* [Golang](./go.md)
* [架构](#architecture)
* [语言与框架选择](#语言与框架)

## Architecture
```
                    +------------------+
                    |       API        |
                    +------------------+
                            |
                            |
                            |
                   +-------------------+
                   |     OAuth 2.0     |
                   +-------------------+
                            |
                            |
       +-------------------------------------------+
       |               |              |            |
       |               |              |            |
       |               |              |            |
 +-----------+  +---------------+  +-------+  +----------+
 |Web Client |  |Browser Client |  |  iOS  |  |  Android |
 +-----------+  +---------------+  +-------+  +----------+
```

* API should mostly written in static, strongly-type languages (Golang or Java), and should be distributed.
* Web client (this refer to server side) as front-end could be written in dynamic languages. They should be restricted to Node.js or PHP 7. Python might be used for supporting roles like natural language processing.
* Even so, we are using 5 types of programming languages: Golang, Java, Swift, Node.js, PHP. The types of languages should be stricted limited.

## 语言与框架

这里列出服务器端开发每种语言可以使用的推荐框架以及模版引擎。框架均优先微服务类。

### Node.js

* 框架 [Koa.js](http://koajs.com/)
* 模版 [Nunjucks](http://mozilla.github.io/nunjucks/) 这是对Python世界的Jinja 2的移植

### PHP
* 框架 [Slim](https://www.slimframework.com/) 一个微框架，依然是基于php-fpm运行的。
* 模版 [Twig](https://twig.symfony.com/) 和Jinja 2很类似 -- 也就是说和Node.js中的Nunjucks很相似。

如果选择使用[swoole](https://www.swoole.com/)这个异步引擎，性能会得到极大的提升。简单理解，它就是PHP版的Node.js，加上类似于Golang的coroutine机制。

### Java

* 框架 [vert.x](https://vertx.io/) Java世界的Node.js。
* 模版 [Thymeleaf](https://www.thymeleaf.org/) 或者其他vert.x支持的模版，见官方文档。
* SQL [jOOQ](https://www.jooq.org/)

对于Java，了解复杂的Maven（文档极不健全）或者Gradle（文档很长，几十章）必不可少。此外可能还需要建立Jenkins作持续集成。

### Golang
Golang基本上不需要框架，标准库已经提供了创建网站的大部分必备工具。

Golang写HTTP服务的特点是，它不需要搭建运行环境，因为Golang直接编译成一个独立的二进制文件。Golang编译器支持跨平台编译，不管你在哪个平台上写代码，都可以在本机直接编译成Linux版本，把编译好的文件直接上传到服务器硬盘上就可以运行了。不需要学习复杂的构建工具。和Unix平台上的工具（如make、rsync、systemd）配合使用就可以满足基本的需求。

### Python
* 框架 [tornado](http://www.tornadoweb.org/en/stable/) 或 [twisted](https://github.com/twisted/twisted)
* 模版 [Jinja 2](http://jinja.pocoo.org/)
