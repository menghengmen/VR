//
//  universityDetailTableViewCell3.h
//  Blinroom
//
//  Created by room Blin on 2016/11/23.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface universityDetailTableViewCell3 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *jiaotongLabel;
+ (instancetype)detailCell3WithTableView:(UITableView *)tableView;
@end
