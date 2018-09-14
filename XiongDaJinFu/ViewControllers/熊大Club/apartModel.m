//
//  apartModel.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "apartModel.h"

@implementation apartModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
//             @"be_liked_apartment" : [XYLikeApartmentModel class]
             
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"likeId" : @"id"
             };
}
@end

@implementation XYLikeApartmentModel


@end
