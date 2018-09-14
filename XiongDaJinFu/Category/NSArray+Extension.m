//
//  NSArray+Extension.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "NSArray+Extension.h"
#import "XYSettingInfoModel.h"
@implementation NSArray (Extension)

-(NSArray *)getRelateInfoArrayWithArray:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in array) {
        for (NSDictionary *dict in self) {
            if ([dict[@"alias"] isEqualToString:str] ) {
                XYSettingInfoModel *model = [XYSettingInfoModel yy_modelWithDictionary:dict];
                [arr addObject:model];
                break;
            }
        }
    }
    return arr;
}

-(NSArray *)getRelateInfoArrayWithArray:(NSArray *)array oldArray:(NSArray *)oldArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in array) {
        for (NSDictionary *dict in oldArray) {
            if ([dict[@"alias"] isEqualToString:str] ) {
                XYSettingInfoModel *model = [XYSettingInfoModel yy_modelWithDictionary:dict];
                [arr addObject:model];
                break;
            }
        }
    }
    return arr;
}
@end
