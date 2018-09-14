//
//  XYHourseDetailDesTVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailDesTVCell.h"

@implementation XYHourseDetailDesTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.desLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    self.desLabel.text = model.intro_zh;
//    self.desLabel.text = @"Oculus最近推出了0.3.1 Preview的SDK，但是由于还是预览版，所以我本次还是使用0.2.5c版本的SDK。开发OculusRift开发者刚入门的问题可能就是如何让用户的所体验到沉浸式的虚拟现实世界的。也就是让玩家有身临其境的感觉，没有边界的概念，转动头部即可观察这个世界。";
}

@end
