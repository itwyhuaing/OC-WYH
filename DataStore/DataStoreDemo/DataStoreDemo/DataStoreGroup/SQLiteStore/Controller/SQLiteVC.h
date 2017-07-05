//
//  SQLiteVC.h
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "YHBaseController.h"

@interface SQLiteVC : YHBaseController

@end

/*
 1.创建表
 create table if not exists 表名
 (
 字段名 类型(字符个数，可以省略) primary key autoincrement,
 字段名 类型(字符个数，可以省略) null(可以省略),
 字段名 类型(字符个数，可以省略) not null(可以省略),
 字段名 类型(字符个数，可以省略) not null(可以省略)
 );
 
 注意类型有integer,text,blob,boolean,varchar等
 
 例如：
 create table if not exists Book
 (
 id integer primary key autoincrement,
 name text,
 url text,
 des text
 );
 
 2.表中插入数据
 insert into 表名 (字段名,字段名,字段名) values ('','','');
 例如
 insert into Book (name,url,des) values ('霍金全集','www.baidu.com','描述');
 
 3.查询
 select 字段名（*代表所有字段，如果有多个字段用英文的,分割） from 表名字 where 字段名=‘’ order by 字段名 desc|asc;
 
 注意：1,where判断，对于integer：> , >= ,< , <=, =,between 值 and 值 等
 2,desc降序  asc升序
 
 例如：
 （1）查询表中所有字段数据
 select * from Book;
 select name,url from Book;
 （2）查询判断的条件
 select * from Book where 字段名='';
 (3)select name,url from Book where name = '钢铁是怎么炼成的'
 
 4.模糊查询
 select 字段名 from 表名 where 字段名 like '%关键字%';
 
 例如
 select * from Book where  name like '%钢铁%';
 
 
 5.IN查询
 select 字段名 from 表名 where 字段名 in ('关键字','关键字');
 
 例如：
 select * from Book where name in ('我的青春','钢铁是怎么炼成的');
 
 6.更新
 update 表名 set 字段名 = '关键字' where 字段名 = 关键字
 例如：
 update Book set url='www.aaa.com' where id = 2
 
 
 7.删除数据
 delete from 表名 where 字段名 = '关键字';
 
 例如：
 delete from Book where name = '霍金全集';
 
 7.1 删除整张表里面的所有数据
 delete from 表名
 
 
 8.删除整张表
 drop table 表名;
 
 9.添加字段
 alter table 表名 add column 字段名 类型;
 
 例如：
 alter table Book add column price integer;
 
 10.求和
 select sum(字段名) from 表名
 
 例如：
 select sum(age) from User
 
 11.求平均值
 select avg(字段名) from 表名
 
 例如：
 select avg(age) from User
 
 12.求最大值
 select max(字段名) from 表名
 
 例如：
 select max(age) from User
 
 13.求最小值
 select min(字段名) from 表名
 
 例如：
 select min(age) from User
 
 14.求元组个数
 select count(*) from 表名
 select count(distinct|all 字段名) from 表名
 
 如果指定DISTINCT短语，则表示在计算时要取消指定列中的重复值。如果不指定DISTINCT短语或指定ALL短语（ALL为缺省值），则表示不取消重复值。
 
 
 例如：
 select count(*) from User
 select count(distinct name) from User;
 
 */
