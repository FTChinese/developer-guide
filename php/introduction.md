## Tools we use

### PHP
* 框架 [Slim](https://www.slimframework.com/) 一个微框架，依然是基于php-fpm运行的。
* 模版 [Twig](https://twig.symfony.com/) 和Jinja 2很类似 -- 也就是说和Node.js中的Nunjucks很相似，十分便于在Node.js、Python、PHP之间迁移模版。当前的Twig版本需要使用PHP 7才行。
* 部署工具推荐[capistrano](http://capistranorb.com/)的较多。不过用来部署Node.js的PM2也可以用来部署PHP（或Python），并且比部署Node.js更简单。
* 现代PHP是有标准的，我们尽量去按照标准做。见[PHP Framework Interoperability Group](https://www.php-fig.org/)

如果选择使用[swoole](https://www.swoole.com/)这个异步引擎，性能会得到极大的提升。简单理解，它就是PHP版的Node.js，加上类似于Golang的coroutine机制。因此，它不需要php-fpm，内置服务器启动以后，Nginx代理过去，这和Node.js、Java的vert.x运行方式一样。

> Modern PHP is less about monolithic frameworks and more about composing solutions from specialized and interoperable components.

管理和安装PHP组件的工具叫[composer](https://getcomposer.org/)。Composer之于PHP，就是NPM之于Node.js。参照Node.js来理解：

 . | PHP | Node.js
-------|-----------|------
包管理  | composer  | npm
安装目录  | vendor  | node_modules
索引网站  | https://packagist.org/  |  https://www.npmjs.com/

PHP工具还可以参考[awesome php](https://github.com/ziadoz/awesome-php)

## Reference

* [PHP the Right Way](http://www.phptherightway.com/)
* [PSR-2: Coding Style Guide](https://www.php-fig.org/psr/psr-2/)
* [Moden PHP](https://www.amazon.com/Modern-PHP-Features-Good-Practices/dp/1491905018)
