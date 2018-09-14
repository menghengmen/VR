//
//  XYSiftTableView.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSiftTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,assign) XYSiftCondition siftCondition;
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSMutableArray *universityArray;
@property (nonatomic,strong) NSMutableArray *priceArray;
@property (nonatomic,strong) UITableView *tableView;
@end
