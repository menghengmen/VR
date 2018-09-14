//
//  XYCommentModel.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/29.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCommentModel.h"

@implementation XYCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"commentId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
//             @"images" : [XYCommentPicModel class],
             };
}
@end

@implementation XYCommentObjectModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"commentId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"comment_obj" : [XYCommentObjectModel class],
             };
}

@end

@implementation XYCommentPicModel


@end
