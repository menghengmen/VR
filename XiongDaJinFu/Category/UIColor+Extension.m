//
//  UIColor+Extension.m
//  Essential-New
//
//  Created by Alex on 16/3/7.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *)colorWithRandomColor
{
    float red = (float)((arc4random()%256)/255.0);
    float green = (float)((arc4random()%256)/255.0);
    float blue = (float)((arc4random()%256)/255.0);
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
