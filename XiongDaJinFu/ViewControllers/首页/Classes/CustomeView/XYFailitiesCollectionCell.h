//
//  XYFailitiesCollectionCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSettingInfoModel.h"
@interface XYFailitiesCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) XYSettingInfoModel *model;
@end
