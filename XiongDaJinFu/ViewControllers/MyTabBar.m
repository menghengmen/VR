//
//  MyTabBar.m
//  XiongDaJinFu
//
//  Created by blinRoom on 16/10/13.
//  Copyright © 2016年 blinRoom. All rights reserved.
//

#import "MyTabBar.h"

@implementation MyTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}



- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@0,@1.0];
            animation.duration = 0.2f;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}
@end
