
//
//  XYSiftPriceTableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSiftPriceTableViewCell.h"
@interface XYSiftPriceTableViewCell()<UITextFieldDelegate>
@end

@implementation XYSiftPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.minPriceTextField.delegate = self;
//    self.maxPriceTextField.delegate = self;
    self.minPriceTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.maxPriceTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.minPriceTextField.clipsToBounds = true;
    self.minPriceTextField.layer.cornerRadius = 6;
    
    self.maxPriceTextField.clipsToBounds = true;
    self.maxPriceTextField.layer.cornerRadius = 6;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUniversity:(NSInteger)university{
    _university = university;
    if (university == 0) {
        self.unitLabel.text = @"英镑/周";
    }else if(university == 1){
        self.unitLabel.text = @"美元/月";
    }
}


- (IBAction)textDidChanged:(UITextField *)sender {
    if (self.textDidChangedBlock) {
        self.textDidChangedBlock(sender);
    }
}
@end
