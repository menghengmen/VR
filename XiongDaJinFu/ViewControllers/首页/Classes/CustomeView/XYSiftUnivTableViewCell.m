//
//  XYSiftUnivTableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSiftUnivTableViewCell.h"

@implementation XYSiftUnivTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYUnivModel *)model{
    _model =model;
    self.nameLabel.text = model.name_zh;
    if (model.isSelected) {
        self.nameLabel.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor colorWithHex:0x29a7e1];
    }else{
        self.nameLabel.textColor = [UIColor colorWithHex:0x666666];
        self.contentView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    }
}

@end
