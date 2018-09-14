//
//  XYFlatListModel.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFlatListModel.h"

@implementation XYFlatListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"faltId" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"images" : [XYFlatListModelImages class],
             @"full_shot_images" : [XYFlatListModelFullShotIamges class],
             @"videos" : [XYFlatListModelVideos class],
             @"full_shot_videos" : [XYFlatListModelFullShotVideos class],
             @"apartment_types" : [XYHourseTypeModel class],
//             @"provider" : [XYSupplyerModel class],
             
             };
}
@end

@implementation XYHourseListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"faltId" : @"id",
             //             @"titleImage" : @"title_image",
             //             @"introEn" : @"intro_en",
             //             @"introZh" : @"intro_zh"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"images" : [XYFlatListModelImages class],
             @"full_shot_images" : [XYFlatListModelFullShotIamges class],
             @"videos" : [XYFlatListModelVideos class],
             @"full_shot_videos" : [XYFlatListModelFullShotVideos class],
//             @"apartment_types" : [XYHourseTypeModel class],
             @"facility" : [XYFatilityModel class],
             
             };
}
@end


@implementation XYFlatListModelImages

@end

@implementation XYFlatListModelFullShotIamges

@end

@implementation XYFlatListModelVideos

@end

@implementation XYFlatListModelFullShotVideos

@end

@implementation XYHourseTypeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"hourseId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"images" : [XYFlatListModelImages class],
             @"full_shot_images" : [XYFlatListModelFullShotIamges class],
             @"videos" : [XYFlatListModelVideos class],
             @"full_shot_videos" : [XYFlatListModelFullShotVideos class],
             @"house_type" : [XYHourseTypeModel class],
//             @"facility" : [XYFatilityModel class],
             
             };
}
@end

@implementation XYFatilityModel

@end

@implementation XYSupplyerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"supplyId" : @"id",
             };
}
@end
