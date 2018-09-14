//
//  XYCustomStatusbar.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/30.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCustomStatusbar.h"
@interface XYCustomStatusbar()

@end

@implementation XYCustomStatusbar


static XYCustomStatusbar *_status;
+(instancetype)sharedStatusBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _status = [[XYCustomStatusbar alloc]init];
    });
    return _status;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews{
    self.frame = [UIApplication sharedApplication].statusBarFrame;
    self.windowLevel = UIWindowLevelStatusBar +1;
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = true;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 20, 20)];
    [self addSubview:imageView];
    imageView.backgroundColor = [UIColor whiteColor];
    self.logoImageView = imageView;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_MAIN.width - 40, 20)];
    [self addSubview:label];
    label.textColor = [UIColor blackColor];
//    label.backgroundColor = [UIColor colorWithRandomColor];
    self.statusTextLabel = label;
}

-(void)showStatusWithString:(NSString *)string delayInSeconds:(double)delayInSeconds{
    self.alpha = 0.0f;
    self.hidden = false;
    self.statusTextLabel.text = string;
    [UIView animateWithDuration:0.1f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (delayInSeconds && delayInSeconds > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hiddenStatusBar];
            });
        }else{
            
        }
    }];
    
}

-(void)hiddenStatusBar{
    [UIView animateWithDuration:0.1f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = true;
    }];
}

@end
