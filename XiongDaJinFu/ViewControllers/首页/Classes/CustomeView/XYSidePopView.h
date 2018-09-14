//
//  XYSidePopView.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,popType) {
    popTypeMid = 1,
    popTypeRight
};
@interface XYSidePopView : UIView
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,assign) BOOL viewIsOn;
@property (nonatomic,strong) UIView *popView;
@property (nonatomic,assign) CGRect formFrame;
@property (nonatomic,assign) popType popType;
@property (nonatomic,assign) BOOL hideWhenClickBackground;
@property (nonatomic,copy) void(^PopViewStatusBlock)(BOOL isShow,UIView *customVIew);
@property (nonatomic,copy) void(^backgroundClickBlock)();

//+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame;
+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame andToView:(UIView*)view andPopType:(popType)popType;
+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame andPopType:(popType)popType;
-(void)dismissplay;
@end
