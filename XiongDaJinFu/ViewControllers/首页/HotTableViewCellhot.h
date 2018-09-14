//
//  HotTableViewCell.h
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,hotType)
{
   
    //推荐房源
    kHouseType =0,
    //热门资讯
    kZhiXunType=1,
   //彼邻客
    kBlinKeType=2,
    



};

@protocol hotTabelViewCellDelegate <NSObject>

- (void)moreBtnClick:(hotType)hotType;

@end



@interface HotTableViewCellhot : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *Maptableview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *linlanel;
@property(nonatomic,assign)  NSInteger  hotType1;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong, nonatomic) IBOutlet UIView *bottom;

@property(nonatomic,weak) id<hotTabelViewCellDelegate> delegate  ;

@property(nonatomic,strong)  HotTableViewCellhot  * model;


+ (instancetype)detailCellroomWithTableView:(UITableView *)tableView ;

- (void)initWithType:(hotType)type;

@end
