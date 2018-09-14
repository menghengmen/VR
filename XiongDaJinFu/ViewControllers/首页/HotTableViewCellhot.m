//
//  HotTableViewCell.m
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "HotTableViewCellhot.h"
#import <UIKit/UIKit.h>




@implementation HotTableViewCellhot


- (void)initWithType:(hotType)type{
    self.hotType1 = type;


    switch (self.hotType1) {
        case kHouseType:
            self.label.text = @"推荐房源";
            break;
        case kZhiXunType:
            self.label.text = @"热门资讯";
            break;
        case kBlinKeType:
            self.label.text = @"彼邻之家";
            self.moreBtn.alpha = 0;
            break;
            
            
            
        default:
            break;
    }

}

+ (instancetype)detailCellroomWithTableView:(UITableView *)tableView {
    static NSString *identity = @"HotTableViewCellhot";
   

    HotTableViewCellhot *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HotTableViewCellhot" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
    
    
}



- (void)setModel:(HotTableViewCellhot*)model{

    _model = model;




}
- (IBAction)moreBtnClick:(UIButton *)sender {


    if ([self.delegate respondsToSelector:@selector(moreBtnClick:)]&&self.delegate) {
        [self.delegate moreBtnClick:self.hotType1];
    }



}



- (void)awakeFromNib {
    [super awakeFromNib];
   [self.moreBtn setTitleColor:[UIColor colorWithHexString:@"29a7e1"] forState:UIControlStateNormal];
    self.label.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.bottom.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
//    self.bottom.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.bottom.layer.shadowOffset = CGSizeMake(-1.0, 1.0);
//    self.bottom.layer.shadowOpacity = YES;
   
    
   // self.moreBtn.hidden = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
