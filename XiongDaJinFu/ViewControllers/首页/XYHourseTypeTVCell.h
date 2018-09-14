//
//  XYHourseTypeTVCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYHourseTypeTVCell : UITableViewCell
//@property (nonatomic,strong) XYFlatListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *hourseIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;
@property (weak, nonatomic) IBOutlet UILabel *hourseNum;
@property (weak, nonatomic) IBOutlet UILabel *unitAndWeekLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *settingCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *annotateLabel;//备注label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pointLabelTop;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtn;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pointLabelHeight;

@property (nonatomic,strong) NSDictionary *settingInfo;

@property (nonatomic,strong) XYHourseTypeModel *model;

@property (nonatomic,strong) NSArray *labelStringArray;

@property (nonatomic,copy) void(^imageClickBlock)();
@property (nonatomic,copy) void(^btnClickBlock)();
@property (nonatomic,copy) void(^moreBtnClickBlock)(BOOL isOpen);
- (IBAction)scheduleBtnClick:(UIButton *)sender;
- (IBAction)moreBtnClick:(id)sender;
@end
