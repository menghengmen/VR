//
//  XYSiftUnivTableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddressModel.h"
@interface XYSiftUnivTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) XYUnivModel *model;
@end
