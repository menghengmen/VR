//
//  XYScheduleNoticeVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYScheduleNoticeVC.h"

@implementation XYScheduleNoticeVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)knowBtnClick:(id)sender {
    if (self.knowBtnClick) {
        self.knowBtnClick();
    }
}
@end
