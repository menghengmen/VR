//
//  XYHourseDetailNameTBVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHourseDetailNameTBVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iocnImageView;

@property (nonatomic,strong) XYFlatListModel *model;
@end
