//
//  RoomTableViewCell.m
//  Blinroom
//
//  Created by Blinroom on 16/8/5.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "RoomTableViewCell.h"

@implementation RoomTableViewCell



- (void)setHModel:(shouCangFangyuan *)HModel{
    _HModel = HModel;
   
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
//    self.namelabel.text = HModel.name;
//    [self.RoomImage sd_setImageWithURL:[NSURL URLWithString:HModel.title_image]];
//    self.labeltwo.text = [NSString stringWithFormat:@"%@",HModel.price];
//
}

-(void)setApartModel:(apartModel *)apartModel{
    _apartModel = apartModel;
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];

//    self.namelabel.text = apartModel.name;
//      [self.RoomImage sd_setImageWithURL:[NSURL URLWithString:apartModel.title_image]];
//    self.labeltwo.text = [NSString stringWithFormat:@"%@",apartModel.price];



}


- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.labeltwo.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.labelthree.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.labelone.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.labeltwo.alpha = 1;
    self.Priceview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    // Initialization code
    self.namelabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.namelabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];

  self.rentstyle.font = [UIFont fontWithName:@"PingFang-SC-Light" size:11];
    self.rentstyle.textColor = [UIColor colorWithHexString:@"#999999"];

}
- (IBAction)deleBtnClick:(UIButton *)sender {
    [self.delegate deleBtnClick];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
