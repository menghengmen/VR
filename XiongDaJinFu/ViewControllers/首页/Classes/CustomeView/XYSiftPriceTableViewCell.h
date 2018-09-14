//
//  XYSiftPriceTableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSiftPriceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *minPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceTextField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;//单位label
@property (nonatomic,assign) NSInteger university;

- (IBAction)textDidChanged:(UITextField *)sender;
@property (nonatomic,copy) void(^textDidChangedBlock)(UITextField *textField);
@end
