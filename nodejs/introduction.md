# Node.js

## Naming conventions

文件名统一使用`-`分割法。每个单词之间都要分割，禁止使用`thisisafile.js`、`thisIsAFile.js`、 `ThisIsAFile.js`、 `this_is_a_file.js`。

## Donts

不要把前端的构建工具直接在后端运行，如`[inline-source](https://github.com/kangax/html-minifier)` `[html-minifier](https://github.com/kangax/html-minifier)`。

如Koajs官网首页有这样一个例子：

```js
const minify = require('html-minifier');

app.use(async (ctx, next) => {
  await next();

  if (!ctx.response.is('html')) return;

  let body = ctx.body;
  if (!body || body.pipe) return;

  if (Buffer.isBuffer(body)) body = body.toString();
  ctx.body = minify(body);
});
```

但实际上即便有少量请求，也会消耗掉所有的CPU资源，大概因为前端工具多数在本地本机运行，不需要考虑性能资源问题，但是在服务器端针对每一个请求运行这些工具是行不通的。

从`inline-source`所使用的依赖看：

```json
{
  "csso": "~3.5.0",
  "htmlparser2": "~3.9.0",
  "superagent": "^3.8.3",
  "svgo": "~1.0.5",
  "uglify-js": "~3.3.25"
}
```

再看`html-minifier`所使用的依赖：
```json
{
  "camel-case": "3.0.x",
  "clean-css": "4.1.x",
  "commander": "2.16.x",
  "he": "1.1.x",
  "param-case": "2.1.x",
  "relateurl": "0.2.x",
  "uglify-js": "3.4.x"
}
```

`[uglify-js](https://github.com/mishoo/UglifyJS2)`本身没有什么依赖，但是它需要对压缩的JS生成抽象语法树。

`[csso](https://github.com/css/csso)`的依赖

```json
{
  "css-tree": "1.0.0-alpha.29"
}
```

`[css-tree](https://github.com/csstree/csstree)`也要对CSS进行解析生成语法树。

`[htmlparser2](https://github.com/fb55/htmlparser2)`需要对HTML进行解析、Tokenization。

`[svgo](https://github.com/svg/svgo)`看上去也是计算量需求很大的工具：
```json
{
  "coa": "~2.0.1",
  "colors": "~1.1.2",
  "css-select": "~1.3.0-rc0",
  "css-select-base-adapter": "~0.1.0",
  "css-tree": "1.0.0-alpha25",
  "css-url-regex": "^1.1.0",
  "csso": "^3.5.0",
  "js-yaml": "~3.10.0",
  "mkdirp": "~0.5.1",
  "object.values": "^1.0.4",
  "sax": "~1.2.4",
  "stable": "~0.1.6",
  "unquote": "~1.1.1",
  "util.promisify": "~1.0.0"
}
```

针对一个请求需要至少同时调用三种解析器，这可能会消耗掉大量CPU资源。
