//
//  XYScheduleOrderVC.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYScheduleOrderVC : UIView

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIButton *nanBtn;
@property (weak, nonatomic) IBOutlet UIButton *nvBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *qqTextField;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtn;

@property (nonatomic,strong) NSDictionary *userInfo;



@property (nonatomic,copy) void(^scheduleBtnClickBlock)(NSDictionary *dict);
- (IBAction)sexBtnClick:(UIButton *)sender;
- (IBAction)sceduleBtnClick:(id)sender;


@end
