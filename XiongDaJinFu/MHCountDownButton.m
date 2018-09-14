//
//  MHCountDownButton.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHCountDownButton.h"

@implementation MHCountDownButton

{
    NSTimer *_timer;
    int _initialTimer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"获取验证码" forState:0];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.layer.cornerRadius = 3.0;
       // [self addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
   }
    return self;
}
-(void)setSecond:(int)second{
    _second = second;
    _initialTimer = _second;
}
-(void)click1{
    //获取验证码
    _countDownButtonBlock();
    //
   
    
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%02d",_second] forState:0];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
}
-(void)timerStart:(NSTimer *)theTimer {
    if (_initialTimer == 1){
        _initialTimer = _second;
        [self stop];
    }else{
        _initialTimer--;
        [self setTitle:[NSString stringWithFormat:@"%02d",_initialTimer] forState:0];
    }
}
- (void)stop{
    self.userInteractionEnabled = YES;
    if (_timer) {
        [_timer invalidate]; //停止计时器
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

-(void)dealloc{  //销毁计时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


@end
