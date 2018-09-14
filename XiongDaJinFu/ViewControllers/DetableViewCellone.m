//
//  DetableViewCellone.m
//  Blinroom
//
//  Created by Blinroom on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "DetableViewCellone.h"

@implementation DetableViewCellone

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)detailViewCellTableView:(UITableView *)tableView{

    static NSString *identity = @"DetableViewCellone";
    DetableViewCellone *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DetableViewCellone" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([super isEditing]) {
        DetableViewCellone*cell=[DetableViewCellone new];
        cell.frame.size.height==300;
    }else {
        //取消编辑时的需要的frame
    }
}
@end
