//
//  noDataTableViewCell.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/25.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "noDataTableViewCell.h"

@implementation noDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];

    self.noDataBtn.layer.borderColor = [[UIColor colorWithHexString:@"#29a7e1"] CGColor];
    self.noDataBtn.layer.borderWidth =0.5;
    self.noDataBtn.font = [UIFont fontWithName:@"PingFang-SC-Light" size:11];
   

    self.noDataBtn.layer.cornerRadius = 4;
    [self.noDataBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)pushList:(UIButton *)sender {

    [self.delegate didPushListBtn];
}

@end
