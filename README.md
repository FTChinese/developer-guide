Reading for FTC Tech Team.

## 原则

对于Web客户端开发，我们对质量的的要求可以分成几层：`Basic`、`Enhanced`。最低等级的要求是`Basic`，一个完整的app必须达到这一级才算及格，并且必须首先达到这一级，有可能你会首先满足了`Enhanced`的要求，却没有达到`Basic`的要求，那么也是不合格的。

`Basic`的要求之一是，Web客户端必须在没有JS的情况下，具备完整的功能，换句话说，服务器端的功能必须完整，用户即便在没有JS的浏览器中，依然可以完成所有的表单填写、可以查看到所有有权限的数据、任何错误都可以得到提示信息。这一阶段的重点工作是必须让服务器端具有完整的功能，即便体验不是很好，即便数据的处理繁复无比，也得保证做到数据的交互必须是持续的，绝不能中断。这一阶段，必须抑制住自己炫技的冲动，不管你的浏览器端JS写得多好、SASS写的多酷炫，都不是这一阶段的重点。掌控力的强大体现在，知道什么时候、什么地方，运用合适的技术。

## 语言

虽然语言并不起决定性作用，但学习任何一门语言总是有成本的，限于人力，我们必须限制语言的选择，不能因为某个人掌握了一门生僻的语言，就任由在公司使用，这会造成使用者离职后无人接手、或者寻找继任者成本极高的局面，所以语言的选择要考虑语言的学习曲线、寻找工程师的难易程度。

Golang。我们主要Golang做基础设施，如API、高并发场景等。已有的经验也证明了，就我们的规模而言，Golang可以用最少的资源换来极佳的效率。

Node.js。这是我们将来的主要工具，主要做Web客户端、使用规模较小的API或需要快速开发出来的原型等。

PHP。这是历史遗留，相关工具链已经长期停留在PHP5、一个古老的Smarty版本和古老的CodeIgnitor框架，即便要用，也必须升级到PHP、现代化的微框架和模版引擎。如果必须使用，PHP和Node.js的作用相同。禁止进入Golang所处的基础设施行列。

Java系。FTC并不提倡Java系的语言。需要用到也是做一些基础设施，和Golang互补。Java系我们只提倡使用Kotlin。不提倡Scalar，学习曲线陡峭，工程师几乎不可能招到，而语言本身高并发的特性，不管是Golang还是Kotlin都可以提供。

移动端iOS用swift；Android用Kotlin。没得选择，没有争议。

其他语言，Rust、C#都很不错，但是我们不会用。Erlang、Haskell自己回家学，但是不要在公司里用，和Scalar同理。

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

