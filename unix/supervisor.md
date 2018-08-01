## 常用命令

### 查看程序运行状态

* `supervisorctl status` 显示进程的状态
* `supervisorctl status <name>` 显示指定进程的状态

### 启动进程

* `supervisorctl start all` 启动`supervisor.conf`中所有进程
* `supervisorctl state <name>` 启动指定进程

### 停止进程

* `supervisorctl stop all` 停止所有进程
* `supervisorctl stop <name>` 停止指定进程

### 查看日志

* `supervisorctl tail -f <name>` 持续显示某个进程的日志。`tail`用法通系统的`tail`命令。
* `supervisorctl clear <name>` 清除指定进程的日志
* `supervisorctl clear all` 清除所有日志

## 配置文件

supervisor配置文件名是`supervisord.conf`，`supervisord`和`supervisorctl`都使用该文件。

该文件的可以放在如下位置，命令按顺序查找，首先找到哪个文件就使用哪个：

1. `$CWD/supervisord.conf`
2. `$CWD/etc/supervisord.conf`
3. `/etc/supervisord.conf`
4. `/etc/supervisor/supervisord.conf`
5. `../etc/supervisord.conf`
6. `../supervisord.conf`

Mac上Homebrew安装的默认位置为`supervisord -c /usr/local/etc/supervisord.ini`,Linux可能是`/etc/supervisord.conf`。

配置文件中`[program:<name>]`是每个程序的配置信息，`<name>`就是上述命令中使用的`<name>`。