## Java

* 框架 [vert.x](https://vertx.io/). Java世界的Node.js。不同的是，vert.x是多线程的，每一个线程上运行类似于Node.js的事件循环机制。你可以把它当成多线程版的Node.js，也会同样遇到“回调地狱”的问题。解决方法是使用[ReactiveX](http://reactivex.io/) -- 好吧，你又得多学一套东西了。
* 模版 [Thymeleaf](https://www.thymeleaf.org/). 或者其他vert.x支持的模版，见官方文档。
* SQL [jOOQ](https://www.jooq.org/). Java里面直接写SQL语句实在很糟糕，无法格式化，只能字符串拼接，所以必须使用某种ORM，那么我们选择使用轻量级的ORM，而不是Hibernate之类学习曲线过于陡峭的工具。

## Kotlin

* Ktor