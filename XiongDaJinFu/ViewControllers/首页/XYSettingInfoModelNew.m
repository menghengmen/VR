//
//  XYSettingInfoModelNew.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSettingInfoModelNew.h"

@implementation XYSettingInfoModelNew
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"child" : [XYSettingInfoChildModel class]
             
             };
}
@end


@implementation XYSettingInfoChildModel



@end
