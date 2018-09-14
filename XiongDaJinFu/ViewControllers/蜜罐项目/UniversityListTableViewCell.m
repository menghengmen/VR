//
//  UniversityListTableViewCell.m
//  Blinroom
//
//  Created by room Blin on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "UniversityListTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation UniversityListTableViewCell



- (void)setUModel:(UniversityModel *)uModel{
    _uModel = uModel;

    self.univervityName.text = uModel.name_zh;
    self.englabel.text = uModel.name_en;
    [self.univervityImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GlobalImageUrl,uModel.title_image]]];

}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
