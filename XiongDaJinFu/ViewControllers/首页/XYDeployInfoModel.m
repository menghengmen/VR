//
//  XYDeployInfoModel.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/31.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYDeployInfoModel.h"

@implementation XYDeployInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"child" : [XYDeployInfoChildModel class]
             
             };
}
@end


@implementation XYDeployInfoChildModel

@end
