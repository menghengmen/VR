//
//  XYHourseDetailDesTVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHourseDetailDesTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (nonatomic,strong) XYFlatListModel *model;
@end
