## Golang
Golang基本上不需要框架，标准库已经提供了创建网站的大部分必备工具。

Golang写HTTP服务的特点是，它不需要搭建运行环境，因为Golang直接编译成一个独立的二进制文件。Golang编译器支持跨平台编译，不管你在哪个平台上写代码，都可以在本机直接编译成Linux版本，把编译好的文件直接上传到服务器硬盘上就可以运行了。不需要学习复杂的构建工具。和Unix平台上的工具（如make、rsync、systemd）配合使用就可以满足基本的需求。

只需要能把外部请求通过Nginx代理到Golang HTTP server运行的端口就可以，这大概是唯一需要配置的地方。

Golang的包管理工具是官方出的[dep](https://golang.github.io/dep/)。在`dep`推出之前，有很多非官方包管理工具，均不再推荐使用。

Golang对开发目录做出了比较严格的限制，为避免在这里出现问题，我们均把源码放在`~/go/src`下面（这是默认设置）。也就是说，每个人本机上的目录都是这样的结构：
```
~/go/bin
    /pkg
    /src
        /github.com
                   /FTChinese
                             /your-project-name
        /gitlab.com
                   /ftchinese
                             /your-project-name
        /golang.org
        /sourcegraph.com
```

编辑器目前使用 VS Code与Golang的结合很好，代码提示、错误提醒、自动测试。

由于Golang不是面向对象的编程语言（当然也不是纯过程式），因此ORM这种面向对象-关系数据的处理方式并不适用于Golang来处理SQL数据库。目前没有什么很好的抽象方式，直接写SQL语句就行了，Golang的[raw string](https://golang.org/ref/spec#String_literals)写SQL语句很方便。

Golang工具可以参考[awesome golang](https://github.com/avelino/awesome-go)

## Dependency Management

Use [dep](https://golang.github.io/dep/)
