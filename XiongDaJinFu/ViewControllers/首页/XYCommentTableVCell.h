//
//  XYCommentTableVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/29.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESCommpicsViewG.h"
#import "XYCommentModel.h"
@interface XYCommentTableVCell : UITableViewCell
@property (nonatomic,strong) UIButton *headerImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) ESCommpicsViewG *picsView;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) XYCommentModel *model;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) void(^headerClickBlock)();
@property (nonatomic,copy) void(^deleteBtnClickBlock)();

-(CGFloat)getTableViewCellHeight:(XYCommentModel *)model;

@end
