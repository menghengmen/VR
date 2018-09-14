//
//  XYTeleConsultView.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/20.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTeleConsultView : UIView

@property (weak, nonatomic) IBOutlet UITextField *nameTextFidle;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFidle;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFidle;
//@property (weak, nonatomic) IBOutlet UIButton *agressBtn;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtn;

@property (nonatomic,strong) NSDictionary *info;

@property (nonatomic,copy) void(^scheduleBtnClickBlock)(NSDictionary *dict);
//- (IBAction)agressBtnClick:(id)sender;
- (IBAction)scheduleBtnClick:(id)sender;
@end
