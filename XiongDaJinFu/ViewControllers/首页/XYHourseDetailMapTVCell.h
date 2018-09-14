//
//  XYHourseDetailMapTVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHourseDetailMapTVCell : UITableViewCell

@property (nonatomic,strong) XYFlatListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic,copy) void(^mapTapBlock)();
@end
