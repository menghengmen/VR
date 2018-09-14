//
//  RoomTableViewCell.h
//  Blinroom
//
//  Created by Blinroom on 16/8/5.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shouCangFangyuan.h"
@protocol deleBtnClick <NSObject>

-(void)deleBtnClick;

@end

@interface RoomTableViewCell : UITableViewCell


@property (nonatomic, strong) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *PriceLable;
@property (weak, nonatomic) IBOutlet UIImageView *RoomImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *citylabel;
@property (weak, nonatomic) IBOutlet UIView *Priceview;
@property (weak, nonatomic) IBOutlet UILabel *labelone;
@property (weak, nonatomic) IBOutlet UILabel *labeltwo;
@property (weak, nonatomic) IBOutlet UILabel *labelthree;
@property (weak, nonatomic) IBOutlet UIImageView *HotImage;
@property (weak, nonatomic) IBOutlet UILabel *homedeta;
@property (weak, nonatomic) IBOutlet UILabel *rentstyle;
@property (weak, nonatomic) IBOutlet UILabel *homenumber;
@property (weak, nonatomic) IBOutlet UIButton *savebutton;

@property  (nonatomic,weak)  id <deleBtnClick>  delegate;

@property   (nonatomic,strong)   shouCangFangyuan * HModel;
@property(nonatomic,strong)  apartModel  * apartModel;


@end
