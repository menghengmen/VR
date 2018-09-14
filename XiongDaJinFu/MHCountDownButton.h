//
//  MHCountDownButton.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHCountDownButton : UIButton
typedef void (^ClickCountDownButtonBlock)();
@property(nonatomic ,assign) int second; //开始时间数
@property(nonatomic ,copy) ClickCountDownButtonBlock countDownButtonBlock; //点击按钮
-(void)click1;
@end
