//
//  RoomTWTableViewCell.m
//  Blinroom
//
//  Created by Blinroom on 16/10/21.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "RoomTWTableViewCell.h"

@implementation RoomTWTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)detailCell4WithTableView:(UITableView *)tableView{
    static NSString *identity = @"RoomTWTableViewCell";
    RoomTWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RoomTWTableViewCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Morenbutton:(id)sender {
}
@end
