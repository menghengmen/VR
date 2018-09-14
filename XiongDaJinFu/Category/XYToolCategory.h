//
//  XYToolCategory.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYToolCategory : NSObject

/**
 *  获取UIView的截图
 *
 *  @param aView 一个UIView对象
 *
 *  @return 截图的UIImage
 */
+ (UIImage *)screenshotFromView:(UIView *)aView;


+ (void )readSettingInfoFromLocalFileAndSave;
+ (NSDictionary *)readLocalSettingInfoFormDefault;
+ (NSString *)getInfoFormDict:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKey:(NSString *)key1;
+ (NSArray *)getInfoFormDict:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKeys:(NSArray *)keys;
+ (NSArray *)getInfoFormDictStrings:(NSDictionary *)dict andPropertyKey:(NSString *)key privateKeys:(NSArray *)keys;
@end
