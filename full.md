Repo: `https://github.com/FTChinese/developer-guide`

# Overview

## TOC

### Node.js

* [Introduction](./nodejs/introduction.md)
* [Project Structure](./nodejs/project-structure.md)

### Golang

* [Introduction](./golang/introduction.md)

### MySQL

* [Introduction](./mysql/mysql.md)

### OS and DevOps

* [Supervisor](./unix/supervisor.md)

### Version Control

* [SSH with Git](./version-control/ssh-with-git)

## External Links and must-read

* [JavaScript Standard Style](https://github.com/standard/standard)
* [Node.js Style Guide](https://github.com/felixge/node-style-guide)
* [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
* [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html)
* [awesome node](https://github.com/sindresorhus/awesome-nodejs)
* [SQL Style Guide](http://www.sqlstyle.guide/)
* [PHP the Right Way](http://www.phptherightway.com/)
* [PSR-2: Coding Style Guide](https://www.php-fig.org/psr/psr-2/)
* [Moden PHP](https://www.amazon.com/Modern-PHP-Features-Good-Practices/dp/1491905018)

## 原则

对于Web客户端开发，我们对质量的的要求可以分成几层：`Basic`、`Enhanced`。最低等级的要求是`Basic`，一个完整的app必须达到这一级才算及格，并且必须首先达到这一级，有可能你会首先满足了`Enhanced`的要求，却没有达到`Basic`的要求，那么也是不合格的。

`Basic`的要求之一是，Web客户端必须在没有JS的情况下，具备完整的功能，换句话说，服务器端的功能必须完整，用户即便在没有JS的浏览器中，依然可以完成所有的表单填写、可以查看到所有有权限的数据、任何错误都可以得到提示信息。这一阶段的重点工作是必须让服务器端具有完整的功能，即便体验不是很好，即便数据的处理繁复无比，也得保证做到数据的交互必须是持续的，绝不能中断。这一阶段，必须抑制住自己炫技的冲动，不管你的浏览器端JS写得多好、SASS写的多酷炫，都不是这一阶段的重点。驾驭能力体现在，知道什么时候、什么地方，运用合适的技术。

针对动态、弱类型语言，一定要约束好自己，做到：

模块化。每一个函数、每一个类，尽量独立、封装起来，放在属于自己的文件里，文件名要能够简单第表达出来这个文件是干什么用的，不要在一个文件中放毫不相干的函数、类。用文件夹、文件去组成一个有机的结构。只有模块化了，才能解偶。

解偶。每一个函数、每一个类、每一个项目，只完成一个工作、一个任务，不要试图在一个函数里试图完成n个功能，一堆if...else。从单元测试开始，写完一个函数、一个类，只调用它能不能完成一个单元测试？

从整体架构上，也需要做到解偶。数据层、UI层、逻辑层，都要相互独立，通过一致的接口来交流。要做到某一层，用完全不同的技术替换了，却不需要更改任何其他层的东西。

每种语言采用统一的项目结构。自己的项目，爱怎么写怎么写，不需要和别人交流，自己方便、自己明白就行。但是作为机构，必须使用统一的目录结构，要保证任何其他人不需要翻开代码，看一眼就明白每个文件、每个文件夹是在干什么。工程不是艺术，这个问题上不要自由发挥，创造力用在代码上。不要在项目结构上制造成本。

## 语言

虽然语言并不起决定性作用，但学习任何一门语言总是有成本的，限于人力，我们应该对语言提供优先的选择，不能因为某个人掌握了一门生僻的语言，就任由在公司使用，这会造成使用者离职后无人接手、或者寻找继任者成本极高的局面，所以语言的选择要考虑语言的学习曲线、寻找工程师的难易程度。

Golang。学习曲线低，性能高。主要做基础设施，如API、高并发场景等。已有的经验也证明了，就我们的规模而言，Golang可以用最少的资源换来极佳的效率。

Node.js。或许我们将来的主要工具，主要做Web客户端、使用规模较小的API或需要快速开发出来的原型等。目前的观察看，稍微复杂点的项目Node.js的CPU占用率很高。原因未知。

PHP。当前网站完全用PHP，相关工具链已经长期停留在比较老的版本，需要升级。新版本可以提供更好的性能，也更加贴近现代语言。

Java系。需要使用的情况下提倡使用Kotlin。不提倡Scalar，学习曲线陡峭，熟悉Scalar的工程师很难找到，成本太高，而语言本身高并发的特性，不管是Golang还是Kotlin都可以提供。

移动端iOS用swift；Android用Kotlin。

其他语言，Rust、C#都很不错，但是我们不会用。Erlang、Haskell自己学可以，但是不要在公司里用，和Scalar同理。

## Architecture
```
                        database
                            |
                            |
                    +------------------+
                    |       API        |
                    +------------------+
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
# Node.js

## Naming conventions

文件名统一使用`-`分割法。每个单词之间都要分割，禁止使用`thisisafile.js`、`thisIsAFile.js`、 `ThisIsAFile.js`、 `this_is_a_file.js`。
## Project structure

FTC开发者的Node.js后端项目必须遵循如下目录结构，禁止在`.gitignore`中添加这些目录。

```
root
  |---- client
  |   |--- main.js
  |   |--- main.css
  |---- middlewares
  |   |--- Framework specific middles files
  |---- models
  |   |--- Database operation
  |---- server
  |   |--- router1.js
  |   |--- router2.js
  |---- test
  |   |--- test-router1.js
  |   |--- test-router2.js
  |---- utils   // helpers not directly related with your core service.
  |---- views
  |   |--- layouts
  |   |   |--- base.html
  |   |--- home.html
  |---- .gitignore
  |---- Dockerfile
  |---- ecosystem.config.js // PM2 configuration
  |---- index.js            // Entry point. DO NOT write detail code here.
  |---- Jenkinsfile
  |---- nodemon.json        // Nodemon configuration
  |---- package-lock.json
  |---- package.json
  |---- README.md
  |---- types.d.ts
```
# Golang

Golang基本上不需要框架，标准库已经提供了创建网站的大部分必备工具。

Golang写HTTP服务的特点是，它不需要搭建运行环境，因为Golang直接编译成一个独立的二进制文件。Golang编译器支持跨平台编译，不管你在哪个平台上写代码，都可以在本机直接编译成Linux版本，把编译好的文件直接上传到服务器硬盘上就可以运行了。不需要学习复杂的构建工具。和Unix平台上的工具（如make、rsync、systemd）配合使用就可以满足基本的需求。

服务器端，只需要能把外部请求通过Nginx代理到Golang HTTP server运行的端口就可以。

Golang的依赖管理工具是官方出的[dep](https://golang.github.io/dep/)。

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

编辑器目前VS Code与Golang的结合很好，代码提示、错误提醒、自动测试。

Golang工具可以参考[awesome golang](https://github.com/avelino/awesome-go)

# MySQL

## Naming Conventions

* 数据库名、表名用 **名词**、**单数**，单词全称，不要使用缩写，仅凭名称就可以让他人了解到这个表、这个列的用途。禁止使用大写。
* column名称有动词的，注意时态。多数时候用过去式、被动式。如`created_at`。
* 表名如果有多个英语单词可供选择，使用表示集合名词的单词。
* 名称由多个单词构成的，使用下划线分割。如: `published_at`，`user_name`。
* 不要使用camelCase。
* 每一个select都要使用`AS`。有的语言的驱动直接使用`AS`的名字做字段名，因此`AS`的名称采用该语言变量的命名规范。如JS或Java可以用`SELECT published_utc AS publishedAt`，Python可以用`SELECT published_utc AS published_at`。但是，如果是输出到restful api的，用camelCase。
* SQL关键字统一大写。非关键字小写。

## 数据类型

### 时间

需要表示时间的地方，避免使用Unix时间戳，尽量使用`DATETIME`，次选`TIMESTAMP`，原因：

* `DATETIME`表示范围从 1000-01-01 00:00:00 到 9999-12-31 23:59:59。

* `TIMESTAMP`范围从 1970-01-01 00:00:01 到 2038-01-19 03:14:07。你无法保证存储当前数据库的系统届时肯定会升级，肯定会解决溢出问题。

* 用原生SQL类型记录时间更易于进行计算，如统计某一天、某一年的数据等。

表示Duration概念的，如一个动作持续了多久，当然还要使用Unix时间戳。

#### 时区选择

使用UTC时间，不管你在哪里，不管你的机器运行在什么时区，统一使用`0`时区时间。时间列的命名最好标示出来这是UTC时间：`created_utc`, `updated_utc`, `published_utc`, `last_modified_utc`，等等。

要保证插入数据时使用UTC，至少有两种办法：

* 保证客户端当前访问进程的时区设置成了UTC0；
* 保证插入的时间是当前UTC0的时间：

```sql
INSERT INTO table_name
SET created_utc = UTC_TIMESTAMP();
```

你可以在取出数据时转换成你想要的时区：
```sql
SELECT DATE_ADD(created_utc, INTERVAL 8 HOUR) AS createdAt
```
这就会输出北京时间。

还可以格式化成ISO 8601格式：
```sql
SELECT DATE_FORMAT(
	DATE_ADD(created_utc, INTERVAL 8 HOUR),
	'%Y-%m-%dT%H:%i:%S+08:00'
) AS createdAt
```

MySQL文档中关于时区的部分分散在不同的章节中，你应该阅读这些：

* [MySQL Server Time Zone Support](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html)
* [Set server options for time zone](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone)
* [Set dynamic system variables for time zone](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_time_zone)
* [Date and Time Functions](https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html)

在`~/my.cnf`中设置时区：
```
[mysqld]
default-time-zone='+00:00'
```

### 用`VARBINARY`和`BINARY`存储比特类型的数据

很多用于表示ID的随机字符串实际上是16进制表示的一串随机比特，如UUID、苹果的device token，这种数据用VARBINARY存储，既可以节省存储空间，也可以加快查询速度。这里需要用到`HEX()`和`UNHEX()`两个函数。`HEX`把二进制数字转换成16进制字符串输出，`UNHEX`则把16进制表示的字符串转换成二进制存储。IP地址也是一串比特，IPv4是32个比特，IPv6是128个比特，也可以使用VARBINARY存储。

可视化的数据库软件（如MySQL Workbench、Sequel Pro）通常有以16进制显示二进制的选项，钩上。

MySQL的`HEX()`默认用大写字母输出，如果你要在客户端把这种值当字符串比较，注意大小写转换。

Examples:

* UUID

```sql
CREATE TABLE user (
	unique_id BINARY(16) NOT NULL,
	UNIQUE INDEX(unique_id)
);
```
NOTE: 这里字段名没有使用uuid，因为uuid是MySQL的一个函数名。

处理UUID：
```sql
INSERT INTO user
SET unique_id = UNHEX(REPLACE(?, '-', ''));
```

取出数据：
```sql
SELECT CONCAT_WS('-',
	SUBSTRING(LOWER(HEX(unique_id)), 1, 8),
	SUBSTRING(LOWER(HEX(unique_id)), 9, 4),
	SUBSTRING(LOWER(HEX(unique_id)), 13, 4),
	SUBSTRING(LOWER(HEX(unique_id)), 17, 4),
	SUBSTRING(LOWER(HEX(unique_id)), 21, 1000)
) AS userId
FROM user;
```

* iOS Device Token
```sql
CREATE TABLE ios_device (
	PRIMARY KEY (token),
	token BINARY(32) NOT NULL,
	created_utc DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

插入数据：
```sql
INSERT INTO ios_device
SET token = HEX(?);
```

取出数据：
```sql
SELECT LOWER(HEX(token)) AS token,
	DATE_ADD(created_utc, INTERVAL 8 HOUR) AS createdAt
FROM ios_device
WHERE token = UNHEX(?);
```

### 使用ENUM
如果一个字段只有固定几个值，使用`ENUM`，如人的性别，只有`male`, `female` (或使用一个字母`m`、`f`)，顶多再加上一个`unknown`或者直接使用`DEFAULT NULL`。

### 使用布尔值
对于只有两种状态的字段，使用`BOOLEAN`。如用户是否处于活跃状态，只有 **是** 或 **否** 两种状态，可以设计成`is_active BOOLEAN NOT NULL DEFAULT FALSE`

# SSH with Git

[Connecting to GitHub with SSH ](https://help.github.com/articles/connecting-to-github-with-ssh/)

## Generate a new SSH key

Although you can use your existing ssh key, it is suggested generating a new one for different host.

First, change to the ssh directory `cd ~/.ssh`. If this directory does not exist, make one `mkdir ~/.ssh`.

Then under this directory, generate ssh key pair with Mac’s built-in command `ssh-keygen`:
```
ssh-keygen -t rsa -b 4096 -N "My PassPhrasE" -C "your_git_email@example.com" -f github_rsa
```
Meaning of each options:

* `-t type` The type of key.
* `-b bits` the number of bits in the key to create. For RSA, the minimum size it 1024 bits and the default is 2048 bits. Generally, 2048 bits is considered sufficient. Here we specify 4096 bits.
* `-N new_passphrase` Each time you use this SSH key, you will be prompted to enter this passphrase. We can save it to keychain later to avoid this repetition.
* `-C comment`  A comment. Actually you can type anything.
* `-f filename` filename for the key pair

You can type `man ssh-keygen` to see all detailed usage.

## Adding you SSH key to the `ssh-agent`

Since macOS Sierra 10.12.2 or later, you will need to modify your `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in your keychain.

```
Host *
 AddKeysToAgent yes
 UseKeychain yes
 HashKnownHosts yes

Host github.com
 HostName github.com
 PreferredAuthentications publickey
 IdentityFile ~/.ssh/github_rsa
```

Add your SSH private key to the ssh-agent.

```
ssh-add -K ~/.ssh/github_rsa
```

## Adding a new SSH key to your GitHub account

Copy the SSH key to clipboard

```
pbcopy < ~/.ssh/github_rsa.pub
```

On you github page, `settings` -> `SSH and GPG keys` -> `Add SSH key`

## Recover SSH key passphrase

If you forgot your SSH key’s passphrase and it already saved in keychain, you can recover it this way

In launchpad, type `keychain` and open `Keychian Access` app. In this app search `ssh`.

Double click on the entry for your SSH key to open a new dialog box.

In the lower-left corner, select `Show password`.

You'll be prompted for your administrative password. Type it into the "Keychain Access" dialog box.

In your terminal `man ssh_config` to see the format for `config` file.
