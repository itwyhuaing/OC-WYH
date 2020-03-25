//
//  DataBaseViewController.m
//  Location
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "DataBaseViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0)

@interface DataBaseViewController ()

@end


@implementation DataBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //控制器，点击空白地方，隐藏键盘
    CGRect cgrect = self.view.frame;
    if (!IOS7_OR_LATER) {
        cgrect.origin.y -= 20;
    }
    UIControl *clickControl = [[UIControl alloc] init];
    clickControl.frame = cgrect;
    [clickControl addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickControl];
    
    // 此句话很重要,表示将clickControl转移到self.view的上面最近一层,这就表示他是在nameTextField等那几个框框的下面
    [self.view sendSubviewToBack:clickControl];
    
    [self transaction];
    [self noTransaction];
    [self transactionByQueue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
//隐藏软键盘
- (void)hideKeyboard
{
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [_sexTextField resignFirstResponder];
}
- (IBAction)save:(id)sender {
    //获取Document文件夹下的数据库文件，没有则创建
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"user.db"];
    NSLog(@"dbPath = %@",dbPath);
    //获取数据库并打开
    //  FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    // 多线程安全FMDatabaseQueue可以替代dataBase
    FMDatabaseQueue *dataBasequeue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    [dataBasequeue inDatabase:^(FMDatabase *db) {
        
        
        if (![db open]) {
            NSLog(@"打开数据库失败");
            return ;
        }
        //创建表（FMDB中只有update和query操作，除了查询其他都是update操作）
        [db executeUpdate:@"create table if not exists user(name text,gender text,age integer) "];
        
        //常用方法有以下3种：
        //    - (BOOL)executeUpdate:(NSString*)sql, ...
        //    - (BOOL)executeUpdateWithFormat:(NSString*)format, ...
        //    - (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments
        
        
        //插入数据
        BOOL inser = [db executeUpdate:@"insert into user values(?,?,?)",_nameTextField.text,_sexTextField.text,_ageTextField.text];
        
        
        if (inser) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息保存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        [db close];
        
        
    }];
    
    
}
//查询全部
- (IBAction)query:(id)sender {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"user.db"];
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if (![dataBase open]) {
        NSLog(@"打开数据库失败");
        return ;
    }
    FMResultSet *resultSet = [dataBase executeQuery:@"select * from user"];
    while ([resultSet next]) {
        int index  = [resultSet columnIndexForName:@"name"];
        int index1 = [resultSet columnIndexForName:@"gender"];
        int index2 = [resultSet columnIndexForName:@"age"];
        //NSString *column  = [resultSet columnNameForIndex:0];
        NSString *column1 = [resultSet columnNameForIndex:1];
        NSString *column2 = [resultSet columnNameForIndex:2];
        //NSString *column3 = [resultSet columnNameForIndex:3];
        NSLog(@"\n %d - %d - %d \n %@ - %@ \n",index,index1,index2,column1,column2);
        
        
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *genter = [resultSet stringForColumn:@"gender"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"\n Name:%@,Gender:%@,Age:%d \n",name,genter,age);
    }
    
    [dataBase close];
}
//条件查询
- (IBAction)queryByCondition:(id)sender {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"user.db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if (![dataBase open]) {
        return ;
    }
    //    FMResultSet *resultSet = [dataBase executeQuery:@"select *from user where name = ?",@"ZY"];
    FMResultSet *resultSet = [dataBase executeQueryWithFormat:@"select * from user where name = %@",@"zy"];
    while ([resultSet next]) {
        NSString *name = [resultSet stringForColumnIndex:0];
        NSString *gender = [resultSet stringForColumn:@"gender"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"Name:%@,Gender:%@,Age:%d",name,gender,age);
    }
    [dataBase close];
}

// 更新数据
- (IBAction)update:(id)sender {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"user.db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if (![dataBase open]) {
        return ;
    }
    //参数必须是NSObject的子类，int,double,bool这种基本类型，需要封装成对应的包装类才可以,注意大写和小写是不一样的
    BOOL update = [dataBase executeUpdate:@"update user set age = ? where name = ?",[NSNumber numberWithInt:24],@"zy"];
    if (update) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息更新成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    [dataBase close];
}

- (IBAction)deleteByCondition:(id)sender
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"user.db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if (![dataBase open]) {
        return ;
    }
    BOOL delete = [dataBase executeUpdateWithFormat:@"delete from user where name = %@",@"zy"];
    if (delete) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息删除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    [dataBase close];
}




#pragma mark -------------------- 演示事务的使用 --------------------


//一: FMDatabase使用事务的方法：
//事务

-(void)transaction {
    NSDate *date1 = [NSDate date];
    
// 创建表
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"mytable1.db"];
    NSLog(@"dbPath = %@",dbPath);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    // 注意这里的判断一步都不能少,特别是这里open的判断
    
    if (![dataBase open]) {
        NSLog(@"打开数据库失败");
        return ;
    }
    
    NSString *sqlStr = @"create table if not exists mytable1(num integer,name varchar(7),sex char(1),primary key(num));";
    BOOL res = [dataBase executeUpdate:sqlStr];
    if (!res) {
        NSLog(@"error when creating mytable1");
        
        [dataBase close];
    }
    
    // 开启事务
    [dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<500; i++) {
            NSNumber *num = @(i+1);
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sex = (i%2==0)?@"f":@"m";
            
            NSString *sql = @"insert into mytable1(num,name,sex) values(?,?,?);";
            BOOL result = [dataBase executeUpdate:sql,num,name,sex];
            if ( !result ) {
                NSLog(@"插入失败！");
                return;
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        // 事务回退
        [dataBase rollback];
    }
    @finally {
        if (!isRollBack) {
            //事务提交
            [dataBase commit];
        }
    }
    
    [dataBase close];
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"FMDatabase使用事务插入500条数据用时%.3f秒",a);
}



//二: FMDatabase不使用事务的方法：

-(void)noTransaction {
    NSDate *date1 = [NSDate date];
    
    // 创建表
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"mytable3.db"];
    NSLog(@"dbPath = %@",dbPath);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    // 注意这里的判断一步都不能少,特别是这里open的判断
    
    if (![dataBase open]) {
        NSLog(@"打开数据库失败");
        return ;
    }
    
    NSString *sqlStr = @"create table if not exists mytable3(num integer,name varchar(7),sex char(1),primary key(num));";
    BOOL res = [dataBase executeUpdate:sqlStr];
    if (!res) {
        NSLog(@"error when creating mytable1");
        
        [dataBase close];
    }
    
        for (int i = 0; i<500; i++) {
            NSNumber *num = @(i+1);
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sex = (i%2==0)?@"f":@"m";
            
            NSString *sql = @"insert into mytable3(num,name,sex) values(?,?,?);";
            BOOL result = [dataBase executeUpdate:sql,num,name,sex];
            if ( !result ) {
                NSLog(@"插入失败！");
                return;
            }
        }
    
    
    [dataBase close];
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"FMDatabase不使用事务插入500条数据用时%.3f秒",a);
}

//三: FMDatabaseQueue 使用事务的方法：

//多线程事务
- (void)transactionByQueue {
    NSDate *date1 = [NSDate date];
    
    // 创建表
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"mytable2.db"];
    
    
    //多线程安全FMDatabaseQueue可以替代dataBase
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    //开启事务
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        if(![db open]){
            
            return NSLog(@"事务打开失败");
        }
        
        NSString *sqlStr = @"create table mytable2(num integer,name varchar(7),sex char(1),primary key(num));";
        BOOL res = [db executeUpdate:sqlStr];
        if (!res) {
            NSLog(@"error when creating mytable2 table");
            
            [db close];
        }
        
        
        for (int i = 0; i<500; i++) {
            NSNumber *num = @(i+1);
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sex = (i%2==0)?@"f":@"m";
            NSString *sql = @"insert into mytable2(num,name,sex) values(?,?,?);";
            BOOL result = [db executeUpdate:sql,num,name,sex];
            if ( !result ) {
                //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交
                *rollback = YES;
                return;
            }
        }
        
      [db close];
    }];
    
    
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"FMDatabaseQueue使用事务插入500条数据用时%.3f秒",a);
}

@end
