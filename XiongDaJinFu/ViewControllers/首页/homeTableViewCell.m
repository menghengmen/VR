//
//  homeTableViewCell.m
//  XiongDaJinFu
//
//  Created by gary on 2016/12/7.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "homeTableViewCell.h"

@implementation homeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)homeTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identity = @"homeTableViewCell";
    homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"homeTableViewCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    



}

@end
