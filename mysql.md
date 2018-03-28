## Reference

* [SQL Style Guide](http://www.sqlstyle.guide/)

## 命名规范

* 数据库名、表名用**名词**、**单数**，单词全称，不要缩写。
* 表名如果有多个英语单词可供选择，使用表示集合名词的单词。
* 名称由多个单词构成的，使用下划线分割。如: `published_at`

## 数据类型

### 时间

尽量使用`DATETIME`，表示范围从 1000-01-01 00:00:00 到 9999-12-31 23:59:59。

`TIMESTAMP`范围从 1970-01-01 00:00:01 到 2038-01-19 03:14:07。你无法保证存储当前数据库的系统届时肯定会升级，肯定会解决溢出问题。

避免使用Unix时间戳，理由同上。更重要的是，人类无法一眼就看出来一长串数字到底指的哪一天，这对直接开发数据库的工程师非常不友好。

时区选择。使用UTC时间，不管你在哪里，不管你的机器运行在什么时区，统一使用`0`时区时间。时间列的命名最好标示出来这是UTC时间：`created_utc`, `updated_utc`, `published_utc`, `last_modified_utc`，等等。

要保证插入数据时使用UTC，至少有两种办法：
* 保证客户端当前访问进程的时区设置成了UTC0；
* 保证插入的时间是当前UTC0的时间：

```sql
INSERT INTO table_name
SET created_utc = UTC_TIMESTAMP();
```

你可以在取出数据是转换成你想要的时区：
```sql
SELECT DATE_ADD(c.created_utc, INTERVAL 8 HOUR) AS createdAt
```
这就会输出北京时间。

还可以格式化成ISO 8601格式：
```sql
SELECT DATE_FORMAT(
	DATE_ADD(c.created_utc, INTERVAL 8 HOUR),
	'%Y-%m-%dT%H:%i:%S+08:00'
) AS createdAt
```

### BINARY存储比特类型的数据

很多用于标示ID的随机字符串实际上16进制表示的一串随机比特，如UUID、苹果的device token，这种数据用BINARY存储，既可以节省存储空间，也可以加快查询速度。
