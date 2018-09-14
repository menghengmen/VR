//
//  PubTableViewCell.h
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *sharelabel;

@property (weak, nonatomic) IBOutlet UILabel *colleclabel;
@property (weak, nonatomic) IBOutlet UILabel *honsename;

+ (instancetype)pubTableViewCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *homeid;

@end
