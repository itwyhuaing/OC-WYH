/** 参考
 iOS 基于FMDB简单的查询操作 https://blog.csdn.net/rpf2014/article/details/53116906
 
 */


#pragma mark ------ 创建表
 /**
  1.创建表
  create table [if not exists] 表名
  (
  属性名 类型(字符个数，可以省略) primary key autoincrement,
  属性名 类型(字符个数，可以省略) null(不可以省略),
  属性名 类型(字符个数，可以省略) not null(可以省略),
  属性名 类型(字符个数，可以省略) not null(可以省略)
  );
  
  create table if not exists student(
  id integer primary key autoincrement,
  name text,
  age  integer,
  addr text
  );
  
  // float
  // text  字符串
  // blob  二进制数据类型  一般 存 图片 或者 mp3  mp4
  注意类型有integer,real,text,blob等
  例如:
  create table if not exists Book
  (
  id integer primary key autoincrement,
  name text,
  url text,
  des text
  );
  */

 #pragma mark ------ 表中插入数据
 /**
  2.表中插入数据
  insert into 表名 (属性名1,属性名2,属性名3) values ('','','');
  
  select id,name,age from hello where age>18;
  insert into hello (name,age,addr) values ('zhangsan',20,'qianfeng');
  例如
  insert into Book (name,url,des) values ('霍金全集','www.baidu.com','描述');
  */

  #pragma mark ------ 查询/读取数据
  /**
  3.查询
  select [属性名,属性名]  from 表名字 [where 字段名=‘’] order by 字段名 desc|asc;
  
  注意：1. where 判断 > , >= ,< , <=, between 字段 and 字段
       2. desc降序  asc升序
  
  例如：
  （1）查询表中所有字段数据
    select * from Book
    select * from Book order by 字段名 desc
    select * from Book order by 字段名 asc
  
  （2）查询 - 单个条件的判断
    select * from Book where 字段名=''
  
   (3) 查询 - 多个条件的判断
   select * from Book where 字段名='' or where 字段名=''
   select * from Book where 字段名='' and where 字段名=''
   select name,url from Book where name = '钢铁是怎么炼成的'
  
   */

#pragma mark ------ 更新
 /**
  4.更新
  update 表名 set 属性名 = '关键字' where 属性名 = 关键字
  
  例如：
  update Book set url='www.aaa.com' where id = 2
  */

#pragma mark ------ 删除数据
/**
  5.删除数据
  delete from 表名 where 属性名 = '关键字';
  
  例如:
  delete from Book where name = '霍金全集';
 */

#pragma mark ------ 删除整张表
/**
  6.删除整张表
  drop table 表名;
 */

#pragma mark ------ 添加属性(字段)
/**
  7.添加属性(字段)
  alter table 表名 add column 属性名 类型;
  
  例如：
  alter table Book add column price integer;
  聚合函数
 */

#pragma mark ------ 求和
/**
  8.求和
  select sum(属性名) from 表名
  
  例如：
  select sum(age) from User
 */

#pragma mark ------ 求平均值
/**
  9.求平均值
  select avg(属性名) from 表名
  
  例如：
  select avg(age) from User
 */

#pragma mark ------ 求最大值
/**
  10.求最大值
  select max(属性名) from 表名
  
  例如：
  select max(age) from User
 */

#pragma mark ------ 求最小值
/**
  11.求最小值
  select min(属性名) from 表名
  
  例如：
  select min(age) from User
 */

#pragma mark ------ 求元组个数
/**
  12.求元组个数
  select count(*) from 表名
  select count(distinct|all 属性名) from 表名
  
  如果指定DISTINCT短语，则表示在计算时要取消指定列中的重复值。如果不指定DISTINCT短语或指定ALL短语（ALL为缺省值），则表示不取消重复值。
  
  
  例如：
  select count(*) from User
  select count(distinct name) from User;
  */





