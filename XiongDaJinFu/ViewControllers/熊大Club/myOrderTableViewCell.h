//
//  myOrderTableViewCell.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"
#import "apartmentModel.h"

@protocol cancleOrderDelegate <NSObject>

-(void)didCancleBtn;

@end

@interface myOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderNamelabel;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *orderState;

@property (strong, nonatomic) IBOutlet UIImageView *imageView1;

@property (strong, nonatomic) IBOutlet UIButton *cancleBtn;
@property (strong, nonatomic) IBOutlet UILabel *calcalLabel;
@property(nonatomic,strong)  orderModel  * oModel;
@property(nonatomic,strong)  apartmentModel  * apartMentModel;

@property (strong, nonatomic) IBOutlet UILabel *keFuPhone;
@property (strong, nonatomic) IBOutlet UILabel *keFuMail;
@property (nonatomic,copy) void(^cancleBtnClick)(NSInteger index);

@property  (nonatomic,weak)  id<cancleOrderDelegate>  delegate;
@end
