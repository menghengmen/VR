//
//  universityDetailTableViewCell3.m
//  Blinroom
//
//  Created by room Blin on 2016/11/23.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "universityDetailTableViewCell3.h"

@implementation universityDetailTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jiaotongLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.jiaotongLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    
    
    self.backView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
}
+ (instancetype)detailCell3WithTableView:(UITableView *)tableView{
    
    static NSString *identity = @"universityDetailCell3";
    universityDetailTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"universityDetailTableViewCell3" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
