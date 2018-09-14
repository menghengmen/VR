//
//  XYHourseDetailNameTBVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailNameTBVCell.h"

@implementation XYHourseDetailNameTBVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iocnImageView.backgroundColor = [UIColor colorWithRandomColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    
    if (model.provider.portrait.length == 0 || !model.provider.portrait) {
        self.iocnImageView.hidden = true;
    }else{
        self.iocnImageView.hidden = false;
    }
    self.noLabel.text = [NSString stringWithFormat:@"房源编号：%@",model.faltId];
    [self.iocnImageView sd_setImageWithURL:[NSURL URLWithString:model.provider.portrait] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
}

@end
