//
//  XYAddressModel.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYAddressModel.h"

@implementation XYAddressModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"addressId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"univs" : [XYUnivModel class],
             };
}
@end


@implementation XYUnivModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"univId" : @"id",
             };
}

@end
