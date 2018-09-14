//
//  XYAbroadResidenceViewController.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYAbroadResidenceViewController : UMengViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *hourseId;
@property (nonatomic,strong) XYFlatListModel *model;
@property (nonatomic,assign) BOOL like;
@property (nonatomic,assign) BOOL facilityIsOpen;//设施是否折叠
@property (nonatomic,copy) void(^likeBtnClickBlock)(BOOL like);

@property (nonatomic,strong) NSDictionary *settingInfo;
@end
