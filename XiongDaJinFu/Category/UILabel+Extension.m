//
//  UILabel+Extension.m
//  Essential-New
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (instancetype)navigationTitleLabelWithText:(NSString *)str {
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor blackColor];
    title.frame = CGRectMake(0, 0, 100, 40);
    title.textAlignment = NSTextAlignmentCenter;
    title.text = str;
    title.font = [UIFont systemFontOfSize:18];
    return title;
}
@end
