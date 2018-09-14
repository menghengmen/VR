//
//  XYUniversityDetailVC.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/13.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYUniversityDetailBaseVC : UIViewController

@property (nonatomic,assign) XYHourseType hourseType;
@property (nonatomic,strong) NSString *university;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL isShowSidePopView;
@end
