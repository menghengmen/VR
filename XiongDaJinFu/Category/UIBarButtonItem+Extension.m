//
//  UIBarButtonItem+Extension.m
//  Essential-New
//
//  Created by Alex on 16/3/18.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)normal highlightImg:(NSString *)highlight {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 32, 32);
    
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (normal) {
        [btn setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    }
    if (highlight) {
        [btn setBackgroundImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    }
    btn.frame = CGRectMake(0, 0, 30, 30);
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

+ (UIBarButtonItem *)fixedBarButtonItemWithSpace:(CGFloat)space {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = space;
    return fixedSpace;
}

+ (UIBarButtonItem *)fixedBarButtonItem {
    return [self fixedBarButtonItemWithSpace:-3];
}

@end
