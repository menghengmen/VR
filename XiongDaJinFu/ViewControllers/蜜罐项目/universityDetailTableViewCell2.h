//
//  universityDetailTableViewCell2.h
//  Blinroom
//
//  Created by room Blin on 2016/10/17.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityModel.h"
@class  universityDetailTableViewCell2;
@protocol universityDetailTableViewCellDelegate <NSObject,UITableViewDelegate>

- (void)detailCell:(universityDetailTableViewCell2 *)Cell didSelectBnt:(NSUInteger)btnIndex;

@end


@interface universityDetailTableViewCell2 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic)IBOutlet  UIView *universityNameView;

@property (strong, nonatomic)IBOutlet  UILabel *universityNameLabel;

@property (strong, nonatomic)IBOutlet  UILabel *universityEnLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView1;

//大学详细简介
@property (strong, nonatomic) IBOutlet UILabel  *introduceLabel;

@property (strong, nonatomic) IBOutlet UIView  *introduceView;



@property (strong, nonatomic) IBOutlet UIView *universityIntroduceView;

@property (strong, nonatomic) IBOutlet UILabel *introduceTitleLabel;

+ (instancetype)detailCell2WithTableView:(UITableView *)tableView;

@property (strong, nonatomic)  UIView *yinYingView;

@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;

@property (strong, nonatomic) IBOutlet UIButton *houseBtn;
@property(nonatomic,weak)  id<universityDetailTableViewCellDelegate>  delegate;
@property(nonatomic,strong)  UniversityModel  * model;

@end
