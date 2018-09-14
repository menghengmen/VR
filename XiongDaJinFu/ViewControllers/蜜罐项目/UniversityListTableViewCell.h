//
//  UniversityListTableViewCell.h
//  Blinroom
//
//  Created by room Blin on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityModel.h"
@interface UniversityListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *univervityName;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *univervityImage;
@property (weak, nonatomic) IBOutlet UILabel *englabel;

@property(nonatomic,strong)  UniversityModel  * uModel;

@end
