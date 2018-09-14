//
//  XYFailitiesCollectionCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFailitiesCollectionCell.h"

@implementation XYFailitiesCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat itemWidth = (SCREEN_MAIN.width -63/2.0 *2 * SCREEN_MAIN.width/414.0 -128/2.0*3 *SCREEN_MAIN.width/414.0)/4;
    self.imageView1.layer.cornerRadius = itemWidth/2.0f;
    
    self.clipsToBounds = false;
}

-(void)setModel:(XYSettingInfoModel *)model{
    _model = model;
    self.imageView1.image = [UIImage imageNamed:@"room_default_img"];
    self.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"HourseSetting_%@",model.alias]];
    self.nameLabel.text = model.name_zh;
}

@end
