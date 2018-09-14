//
//  XYSiftHourseNumTableVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/9.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYSiftButton.h"
@interface XYSiftHourseNumTableVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYSiftButton *btn1;
@property (weak, nonatomic) IBOutlet XYSiftButton *btn2;
@property (weak, nonatomic) IBOutlet XYSiftButton *btn3;
@property (weak, nonatomic) IBOutlet XYSiftButton *btn4;
@property (weak, nonatomic) IBOutlet XYSiftButton *btn5;
@property (weak, nonatomic) IBOutlet XYSiftButton *btn6;
- (IBAction)btnClick:(XYSiftButton *)sender;

@property (nonatomic,copy) void(^btnClickBlock)(XYSiftButton * btn);
@end
