//
//  XYSiftHourseNumTableVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/9.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSiftHourseNumTableVCell.h"
@implementation XYSiftHourseNumTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn1.isSelectOnly = false;
    _btn2.isSelectOnly = false;
    _btn3.isSelectOnly = false;
    _btn4.isSelectOnly = false;
    _btn5.isSelectOnly = false;
    _btn6.isSelectOnly = false;
    
    _btn1.imageView1 = nil;
    _btn2.imageView1 = nil;
    _btn3.imageView1 = nil;
    _btn4.imageView1 = nil;
    _btn5.imageView1 = nil;
    _btn6.imageView1 = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnClick:(XYSiftButton *)sender {
    
    for (int i = 0; i<6; i++) {
        XYSiftButton *btn = (XYSiftButton *)[self viewWithTag:i +600];
        if (sender.tag -600 == i) {
            btn.isSelectOnly = !btn.isSelectOnly;
        }else{
            btn.isSelectOnly = false;
        }
    }
    
    if (self.btnClickBlock) {
        self.btnClickBlock(sender);
    }
}
@end
