//
//  UIColor+Extension.h
//  Essential-New
//
//  Created by Alex on 16/3/7.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *)colorWithRandomColor;///< 随机色

@end
