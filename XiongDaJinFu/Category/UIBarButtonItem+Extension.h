//
//  UIBarButtonItem+Extension.h
//  Essential-New
//
//  Created by Alex on 16/3/18.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)normal highlightImg:(NSString *)highlight;

+ (UIBarButtonItem *)fixedBarButtonItemWithSpace:(CGFloat)space;

+ (UIBarButtonItem *)fixedBarButtonItem;
@end
