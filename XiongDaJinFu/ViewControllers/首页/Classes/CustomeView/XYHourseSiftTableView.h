//
//  XYHourseSiftTableView.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYHourseSiftTableView : UIView
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *uniLabel;
@property (nonatomic,assign) XYHourseType hourseType;
@property (nonatomic,copy) void(^btnClickeBlock)(UIButton *button,NSMutableDictionary *dict);
@end
