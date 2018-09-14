//
//  XYSidePopView.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSidePopView.h"

@implementation XYSidePopView

+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame andPopType:(popType)popType{
    XYSidePopView *popView =[[XYSidePopView alloc]initWithFrame:frame withView:customView andPopType:popType];
    popView.hideWhenClickBackground = true;
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    return popView;
}

+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame andToView:(UIView*)view andPopType:(popType)popType{
    XYSidePopView *popView =[[XYSidePopView alloc]initWithFrame:frame withView:customView andPopType:popType];
    popView.hideWhenClickBackground = true;
    [view addSubview:popView];
    return popView;
}

//+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame{
//    XYSidePopView *popView =[[XYSidePopView alloc]initWithFrame:frame withView:customView];
//    [[UIApplication sharedApplication].keyWindow addSubview:popView];
//    return popView;
//}
+(instancetype)initWithCustomView:(UIView *)customView andBackgroundFrame:(CGRect)frame{
    XYSidePopView *popView =[[XYSidePopView alloc]initWithFrame:frame withView:customView];
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    return popView;
}

-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view andPopType:(popType)popType{
    if (self = [super initWithFrame:frame]) {
        //背景
        self.popType = popType;
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.width, SCREEN_MAIN.height)];
        back.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [back addGestureRecognizer:tap1];
        [self addSubview:back];
        
        UIView *background =[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.backgroundColor =[UIColor blackColor];
        background.alpha =0.0f;
        self.userInteractionEnabled = true;
        background.userInteractionEnabled = true;
        self.hidden = true;
        self.backgroundView =background;
        [self addSubview:background];
        
        self.popView =view;
        [self addSubview:view];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [background addGestureRecognizer:tap];
        
        self.viewIsOn = true;
        if (self.popType == popTypeRight) {
            
            //TODO: 添加侧滑手势
            UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelePan:)];
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            [self.popView addGestureRecognizer:swipe];
        }
    }
    return self;
}

-(void)handelePan:(UISwipeGestureRecognizer *)pan{
    self.viewIsOn = false;
}

-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view{
    if (self = [super initWithFrame:frame]) {
        //背景
        UIView *background =[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.backgroundColor =[UIColor blackColor];
        background.alpha =0.0f;
        self.userInteractionEnabled = true;
        background.userInteractionEnabled = true;
        self.hidden = true;
        self.backgroundView =background;
        [self addSubview:background];
        
        self.popView =view;
        [self addSubview:view];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [background addGestureRecognizer:tap];
        
        self.viewIsOn = true;
    }
    return self;
}

-(void)setHideWhenClickBackground:(BOOL)hideWhenClickBackground{
    _hideWhenClickBackground = hideWhenClickBackground;
}

-(void)tap{
    
    if (self.hideWhenClickBackground) {
        self.viewIsOn = false;
    }
    
    
    if (self.backgroundClickBlock) {
        self.backgroundClickBlock();
    }
}

-(void)dismissplay{
    if (self.popType == popTypeRight) {
        [UIView animateWithDuration:0.5f animations:^{
            self.backgroundView.alpha =0.0f;
            self.popView.x =SCREEN_MAIN.width;
        } completion:^(BOOL finished) {
            self.hidden = true;
            if (self.PopViewStatusBlock) {
                self.PopViewStatusBlock(false,self.popView);
            }
        }];
    }else if (self.popType == popTypeMid){
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundView.alpha =0.0f;
            self.popView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.hidden = true;
            if (self.PopViewStatusBlock) {
                self.PopViewStatusBlock(false,self.popView);
            }
        }];
    }
}

-(void)show{
    if (self.popType == popTypeRight) {
        [UIView animateWithDuration:0.5f animations:^{
            self.hidden = false;
            self.backgroundView.alpha =0.6f;
            self.popView.x = SCREEN_MAIN.width - self.popView.width;
        } completion:^(BOOL finished) {
            if (self.PopViewStatusBlock) {
                self.PopViewStatusBlock(true,self.popView);
            }
        }];
    }else if (self.popType == popTypeMid){
        [UIView animateWithDuration:0.5f animations:^{
            self.hidden = false;
            self.backgroundView.alpha =0.6f;
            self.popView.alpha =1.0f;
        } completion:^(BOOL finished) {
            if (self.PopViewStatusBlock) {
                self.PopViewStatusBlock(true,self.popView);
            }
        }];
    }
}

-(void)setViewIsOn:(BOOL)viewIsOn{
    _viewIsOn = viewIsOn;
    if (viewIsOn == true) {
        [self show];
    }else{
        [self dismissplay];
    }
    
}

@end
