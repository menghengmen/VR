//
//  UIBarButtonItem+Extension.h
//  快看漫画
//
//  Created by 金亮齐 on 2016/12/13.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+ (instancetype)barButtonItemWithImage:(NSString *)image
                            pressImage:(NSString *)pressImage
                                target:(id)target action:(SEL)action;

- (instancetype)initWithImage:(NSString *)image
                   pressImage:(NSString *)pressImage
                       target:(id)target action:(SEL)action;

@end
