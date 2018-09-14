//
//  UIButton+Extension.h
//  Essential-New
//
//  Created by Alex on 16/3/23.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    ButtonImageTitleStyleDefault = 0,      //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,        //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight    = 2,    //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom    = 4,    //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,    //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,    //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};


@interface UIButton (Extension)
- (void)adjustImage:(CGFloat)imgDisplacement title:(CGFloat)titleDisplacement;

/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 
 */
- (void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

+(UIButton *)buttonWithTitle:(NSString *)title titleColour:(UIColor *)titleColour image:(NSString *)image backgroundImage:(NSString *)backgroundImage target:(id)target action:(SEL)action borderColour:(UIColor *)borderColour borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius backgroundColour:(UIColor *)backgroundColour;

@end
