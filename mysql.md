## Reference

* [SQL Style Guide](http://www.sqlstyle.guide/)

## 命名规范

* 数据库名、表名用**名词**、**单数**，单词全称，不要使用缩写，仅凭名称就可以让他人了解到这个表、这个列的用途。
* 名称有动词的，注意时态。多数时候用过去式、被动式。如`created_at`。
* 表名如果有多个英语单词可供选择，使用表示集合名词的单词。
* 名称由多个单词构成的，使用下划线分割。如: `published_at`，`user_name`。
* 不要使用camelCase。
* 每一个select都要使用`AS`。Restful API输出JSON格式数据，因此`AS`的名称采用camelCase。如`SELECT published_utc AS publishedAt`。
* SQL关键字统一大写。非关键字小写。

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

### BINARY存储比特类型的数据

很多用于标示ID的随机字符串实际上是16进制表示的一串随机比特，如UUID、苹果的device token，这种数据用BINARY存储，既可以节省存储空间，也可以加快查询速度。这里需要用到`HEX()`和`UNHEX()`两个函数。`HEX`把二进制数字转换成16进制字符串输出，`UNHEX`则把16进制表示的字符串转换成二进制存储。IP地址也是一串比特，IPv4是32个比特，IPv6是128个比特，也可以考虑使用BINARY存储。

可视化的数据库软件（如MySQL Workbench、Sequel Pro）通常有以16进制显示二进制的选项，钩上。

MySQL的`HEX()`默认用大写字母输出，如果你要在客户端把这种值当字符串比较，注意大小写转换。

Examples:

* UUID

```sql
CREATE TABLE user (
	unique_id 	BINARY(16) NOT NULL,
				UNIQUE INDEX(unique_id)
);
```
NOTE: 这里字段名没有使用uuid，因为uuid是MySQL的一个函数名。

插入数据：
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
	token		BINARY(32)	NOT NULL,
	created_utc DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP
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
对于只有两种状态的字段，使用`BOOLEAN`。如用户是否处于活跃状态，只有是或否两种状态，可以设计成`is_active BOOLEAN NOT NULL DEFAULT FALSE`
