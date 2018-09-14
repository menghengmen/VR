//
//  XYHourseDetailTableVC.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "BaseViewController.h"
#import "XYFlatListModel.h"

@interface XYHourseDetailTableVC : UMengViewController

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *faltId;
@property (nonatomic,strong) XYFlatListModel *model;
@property (nonatomic,assign) BOOL facilityIsOpen;//设施是否折叠
@property (nonatomic,assign) BOOL like;
@property (nonatomic,copy) void(^likeBtnClickBlock)(BOOL like);

@property (nonatomic,strong) NSDictionary *settingInfo;

@end
