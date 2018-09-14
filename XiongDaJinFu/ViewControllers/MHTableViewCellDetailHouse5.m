//
//  MHTableViewCellDetailHouse5.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHTableViewCellDetailHouse5.h"

@implementation MHTableViewCellDetailHouse5

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)detailCell5WithTableView:(UITableView *)tableView{

    static NSString *identity = @"MHTableViewCellDetailHouse5";
    MHTableViewCellDetailHouse5 *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MHTableViewCellDetailHouse5" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
