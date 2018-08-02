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
