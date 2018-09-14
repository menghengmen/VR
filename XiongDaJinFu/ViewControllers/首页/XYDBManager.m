//
//  XYDBManager.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/1.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYDBManager.h"

@implementation XYDBManager
{
    FMDatabase *_db;
}
+(XYDBManager *)sharedDBManager{
    static XYDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XYDBManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        //创建或获取数据库文件
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        NSArray *ids = [bundleId componentsSeparatedByString:@"."];
        NSString *dbPath = [NSString stringWithFormat:@"%@/%@%@",doc,ids.lastObject,@"DB.sqlite"];
        LxDBAnyVar(dbPath);
        
        _db = [FMDatabase databaseWithPath:dbPath];
        if (![_db open]) {
            LxDBAnyVar(@"打开或创建数据库失败");
            return nil;
        }
    }
    return self;
}

-(void)creatOrOpenTableWithName:(NSString *)tableName{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    FMResultSet *rs = [_db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
//        NSLog(@"The table count: %li", count);
        if (count == 1) {
            LxDBAnyVar(@"表已经存在");
            return;
        }
        LxDBAnyVar(@"表不存在");
        //创建表
        NSString *creatTableSql = [NSString stringWithFormat:@"CREATE TABLE %@ (Name text, Age integer, Sex integer,Height integer, Weight integer, Photo blob)",tableName];
        BOOL cuccess = [_db executeUpdate:creatTableSql];
        if (cuccess) {
            LxDBAnyVar(@"打开或创建表成功");
        }else{
            LxDBAnyVar(@"打开或创建表失败");
        }
    }  
    
    [rs close];
}





@end
