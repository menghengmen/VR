//
//  XYToolCategory.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYToolCategory.h"
#import "XYSettingInfoModelNew.h"
@implementation XYToolCategory


+ (UIImage *)screenshotFromView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

+(void )readSettingInfoFromLocalFileAndSave{
//    dispatch_queue_t queue = dispatch_queue_create("settingInfoLocal", DISPATCH_QUEUE_SERIAL);
    
//    NSMutableArray *arr  = [NSMutableArray array];
    //文件路径
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [pathArray objectAtIndex:0];
    NSString *newFilePath = [documentsPath stringByAppendingPathComponent:@"allDictionary.plist"];
    //获取文件信息
    NSDictionary  * peiZhiDict = [NSDictionary dictionaryWithContentsOfFile:newFilePath];
    NSArray  * dataArray = [peiZhiDict objectForKey:@"result"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted    error:nil];
    [defaults setObject:data forKey:userSettingInfoKey];
    [defaults synchronize];
}

+ (NSDictionary *)readLocalSettingInfoFormDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData  *data = [defaults  dataForKey:userSettingInfoKey];
    if (!data) {
        return nil;
    }
    
    NSArray *result = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    for (NSDictionary *dict1 in result) {
        XYSettingInfoModelNew *model = [XYSettingInfoModelNew yy_modelWithDictionary:dict1];
        [dict setObject:model forKey:model.alias];
    }
    return dict;
}

+ (NSString *)getInfoFormDict:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKey:(NSString *)key1{
    XYSettingInfoModelNew *model = [dict objectForKey:key];
    for (XYSettingInfoChildModel *child in model.child) {
        if ([child.alias isEqualToString:key1]) {
            return child.name_zh;
        }
    }
    return nil;
}

+ (NSArray *)getInfoFormDict:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKeys:(NSArray *)keys{
    NSMutableArray *arr = [NSMutableArray array];
    XYSettingInfoModelNew *model = [dict objectForKey:key];
    for (int i = 0; i<keys.count; i++) {
        for (XYSettingInfoChildModel *child in model.child) {
            if ([child.alias isEqualToString:keys[i]]) {
                [arr addObject:child];
                break;
            }
        }
    }
    return arr;
}

+ (NSArray *)getInfoFormDictStrings:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKeys:(NSArray *)keys{
    NSMutableArray *arr = [NSMutableArray array];
    XYSettingInfoModelNew *model = [dict objectForKey:key];
    for (int i = 0; i<keys.count; i++) {
        for (XYSettingInfoChildModel *child in model.child) {
            if ([child.alias isEqualToString:keys[i]]) {
                [arr addObject:child.name_zh];
                break;
            }
        }
    }
    return arr;
}
@end
