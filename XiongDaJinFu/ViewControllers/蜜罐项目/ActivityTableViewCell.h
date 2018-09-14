//
//  ActivityTableViewCell.h
//  Blinroom
//
//  Created by room Blin on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityModel.h"
#import "universityTitleImage.h"
@interface ActivityTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backgroundView2;
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityPlace;
@property (weak, nonatomic) IBOutlet UILabel *activityTime;

@property(nonatomic,strong)  UniversityModel  * uModel;


////快速返回一个cell
//+ (instancetype)ActivityCellWithTableView:(UITableView*)tableView;


@end
