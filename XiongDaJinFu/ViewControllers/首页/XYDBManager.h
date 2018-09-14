//
//  XYDBManager.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/1.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDBManager : NSObject
@property (nonatomic,strong) NSString *currentTable;//当前表
+(XYDBManager *)sharedDBManager;


/**
 用表名建表（有则打开，没有则创建）

 @param TableName 表的名字
 */
-(void)creatOrOpenTableWithName:(NSString *)tableName;
@end
