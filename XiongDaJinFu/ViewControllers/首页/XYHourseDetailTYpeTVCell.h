//
//  XYHourseDetailTYpeTVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHourseDetailTYpeTVCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray  *modelsArray;

@property (nonatomic,strong) NSDictionary *settingInfo;

@property (nonatomic,strong) XYFlatListModel *model;
@property (nonatomic,copy) void(^scheduleClickBlock)(NSInteger index);
@property (nonatomic,copy) void(^imageClickBlock)(NSInteger index);
@property (nonatomic,copy) void(^moreBtnClickBlock)(BOOL isOpen,NSInteger index);
@end
