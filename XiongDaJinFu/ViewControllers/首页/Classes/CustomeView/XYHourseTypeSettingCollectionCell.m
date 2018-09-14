//
//  XYHourseTypeSettingCollectionCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/25.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseTypeSettingCollectionCell.h"

@implementation XYHourseTypeSettingCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textLabel.layer.borderWidth = 0.5f;
    self.textLabel.layer.borderColor = [UIColor colorWithHex:0x29a7e1].CGColor;
}

@end
