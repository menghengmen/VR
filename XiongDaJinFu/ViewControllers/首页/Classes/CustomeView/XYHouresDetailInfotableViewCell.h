//
//  XYHouresDetailInfotableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/13.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHouresDetailInfotableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;
@property (weak, nonatomic) IBOutlet UILabel *hourseTypelabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLable;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtn;
@property (nonatomic,copy) void(^scheduleBtnClickBlock)();

- (IBAction)scheduleBtnClick:(UIButton *)sender;

@property (nonatomic,strong) XYFlatListModel *model;
@end
