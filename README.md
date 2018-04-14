Reading for FTC Tech Team.

## Style Guide and Pitfalls

* [MySQL](./mysql.md)
* [Node.js](./node.md)
* [PHP](./php.md)
* [Golang](./go.md)

## Table of Contents

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

下述框架，只有Slim属于传统PHP架构需要使用FastCGI配合服务器软件（Nginx）调度进程，其余要么采用异步模式，要么就是Golang的Goroutine模式，框架或者语言本身负责调度，服务器软件只需反向代理过去即可。

### Node.js

* 框架 [Koa.js](http://koajs.com/)
* 模版 [Nunjucks](http://mozilla.github.io/nunjucks/) 这是对Python世界的Jinja 2的移植

### PHP
* 框架 [Slim](https://www.slimframework.com/) 一个微框架，依然是基于php-fpm运行的。
* 模版 [Twig](https://twig.symfony.com/) 和Jinja 2很类似 -- 也就是说和Node.js中的Nunjucks很相似。

如果选择使用[swoole](https://www.swoole.com/)这个异步引擎，性能会得到极大的提升。简单理解，它就是PHP版的Node.js，加上类似于Golang的coroutine机制。因此，它不需要php-fpm，内置服务器启动以后，Nginx代理过去，这和Node.js、Java的vert.x运行方式一样。

### Java

* 框架 [vert.x](https://vertx.io/) Java世界的Node.js。不同的是，vert.x是多线程的，每一个线程上运行类似于Node.js的事件循环机制。你可以把它当成多线程版的Node.js，也会同样遇到”回调地狱“的问题。解决方法是使用[ReactiveX](http://reactivex.io/) -- 好吧，你又得多学一套东西了。
* 模版 [Thymeleaf](https://www.thymeleaf.org/) 或者其他vert.x支持的模版，见官方文档。
* SQL [jOOQ](https://www.jooq.org/) Java里面直接写SQL语句实在很糟糕，无法格式化，只能字符串拼接，所以必须使用某种ORM。

对于Java，了解复杂的Maven（文档极不健全）并习惯写XML，或者Gradle（文档很长，几十章）以及它所使用DSL语言，必不可少。此外可能还需要建立Jenkins作持续集成 -- 以及它使用的DSL语言。

能使用Vert.x之前的投入比较高。当然，使用Java的其他框架也一样，Spring全家桶比这些要学的更多。

### Golang
Golang基本上不需要框架，标准库已经提供了创建网站的大部分必备工具。

Golang写HTTP服务的特点是，它不需要搭建运行环境，因为Golang直接编译成一个独立的二进制文件。Golang编译器支持跨平台编译，不管你在哪个平台上写代码，都可以在本机直接编译成Linux版本，把编译好的文件直接上传到服务器硬盘上就可以运行了。不需要学习复杂的构建工具。和Unix平台上的工具（如make、rsync、systemd）配合使用就可以满足基本的需求。

只需要能把外部请求通过Nginx代理到Golang HTTP server运行的端口就可以，这大概是唯一需要配置的地方。

### Python
* 框架 [tornado](http://www.tornadoweb.org/en/stable/) 或 [twisted](https://github.com/twisted/twisted) 两个异步框架。和上述相比，综合而言没有比较优势，除非是Python忠实用户。
* 模版 [Jinja 2](http://jinja.pocoo.org/) 简洁强大的模版引擎
