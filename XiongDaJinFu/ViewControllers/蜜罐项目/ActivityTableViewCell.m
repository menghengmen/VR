//
//  ActivityTableViewCell.m
//  Blinroom
//
//  Created by room Blin on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ActivityTableViewCell

//+ (instancetype)ActivityCellWithTableView:(UITableView *)tableView{
//
//   static  NSString  * indentify = @"activityListCell";
//   
//
//    ActivityTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:indentify];
//    if (!cell) {
//        cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
//    }
//
//    return cell;
//
//}
- (void)setUModel:(UniversityModel *)model{
    _uModel = model;
    self.activityName.text = model.name_zh;
    self.activityTime.text = model.name_en;
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.title_image]]placeholderImage:[UIImage imageNamed:@"main_default_img"]];
}



- (void)awakeFromNib {
    [super awakeFromNib];
   
    //self.activityImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.activityName.textAlignment = NSTextAlignmentCenter;

    self.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];

    self.activityName.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:19];
    self.activityTime.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.activityName.textColor = [UIColor colorWithHexString:@"ffffff"];
    self.activityTime.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.activityTime.textColor = [UIColor colorWithHexString:@"ffffff"];
    
    self.backgroundView2.backgroundColor =[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.4f];
    self.selectionStyle =UITableViewCellSelectionStyleNone;


    self.activityImage.contentMode = UIViewContentModeScaleAspectFill;
    self.activityImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
