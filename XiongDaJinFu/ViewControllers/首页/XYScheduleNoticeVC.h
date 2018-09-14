//
//  XYScheduleNoticeVC.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYScheduleNoticeVC : UIView
@property (nonatomic,copy) void(^knowBtnClick)();
- (IBAction)knowBtnClick:(id)sender;
@end
