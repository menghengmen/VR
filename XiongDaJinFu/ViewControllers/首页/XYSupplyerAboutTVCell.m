//
//  XYSupplyerAboutTVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSupplyerAboutTVCell.h"

@implementation XYSupplyerAboutTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseUrl,model.title_image]] placeholderImage:[UIImage imageNamed:@"Yosemite00"]];
    self.desLabel.text = model.intro_zh;
//    self.desLabel.text = @"《生死狙击》是由无端科技开发的一款3D第一人称射击（FPS）网页游戏，于2013年9月发行。本作采用无端科技自主优化引擎，拥有多种作战模式 ，实现客户端FPS游戏常规玩法无端化，由黄晓明代言。 2016年12月10日，教主黄晓明携代言手游《生死狙击》在应用宝开启直播首秀。";
}

@end
