//
//  XYFlatListTableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
#import "shouCangFangyuan.h"
#import "apartModel.h"
@interface XYFlatListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flatImageView;
@property (weak, nonatomic) IBOutlet UIButton *favouriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *flatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *labelBtn;
@property (weak, nonatomic) IBOutlet UIView *showdownView;
@property (weak, nonatomic) IBOutlet UIButton *labelBtn2;
@property (nonatomic,strong) XYFlatListModel *model;
@property (nonatomic,strong) apartModel *apartModel;

@property (nonatomic,assign) XYHourseType type;
@property (nonatomic,strong) NSDictionary *settingDict;
@property (nonatomic,strong) NSString *country;

@property (nonatomic,copy) void(^likeBtnClickBlock)(BOOL like);

- (IBAction)favouriteBtnClick:(id)sender;
@end
