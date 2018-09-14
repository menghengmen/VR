//
//  XYHourseSiftHeader.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseSiftHeader.h"

@implementation XYHourseSiftHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

- (IBAction)openBtnClick:(id)sender {
    self.isOpen = !self.isOpen;
    if (self.openBtnClickBlock) {
        self.openBtnClickBlock(self.isOpen);
    }
}

-(void)setIsOpen:(BOOL)isOpen{
    [self.openBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:2];
    _isOpen = isOpen;
    if (_isOpen) {
        [self.openBtn setTitle:@"收起" forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"icon_shaixuan_more_up"] forState:UIControlStateNormal];
    }else{
        [self.openBtn setTitle:@"更多" forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"icon_shaixuan_more_down"] forState:UIControlStateNormal];
    }
}


- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag == 1001) {
        [self.UKBtn setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
        [self.USABtn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    }else if(sender.tag == 1002){
        [self.UKBtn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self.USABtn setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.sliderViewLeftMargin.constant = 145 *(sender.tag -1001);
//        LxDBAnyVar(self.sliderView.frame);
    }];
    
    if (self.segmentClickBlock) {
        self.segmentClickBlock(sender.tag -1001);
    }
}

@end
