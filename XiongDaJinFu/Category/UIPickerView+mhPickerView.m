//
//  UIPickerView+mhPickerView.m
//  Blinroom
//
//  Created by room Blin on 2016/12/19.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "UIPickerView+mhPickerView.h"

@implementation UIPickerView (mhPickerView)
//- (void)clearSpearatorLine
//{
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView   obj, NSUInteger idx, BOOL  stop) {
//        if (obj.frame.size.height < 1)
//        {
//            [obj setBackgroundColor:[UIColor clearColor]];
//        }
//    }];
//
//
//
//
//
//}

- (void)clearSpearatorLine
{
    for (UIView  *subView1 in self.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}


@end
