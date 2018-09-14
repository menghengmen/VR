//
//  PubTableViewCell.m
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "PubTableViewCell.h"

@implementation PubTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
+ (instancetype)pubTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identity = @"universityDetailCell1";
    PubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PubTableViewCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    





}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)Sharebutton:(id)sender {
   
    NSLog(@"fenxiang");
    
}

    
    

@end
