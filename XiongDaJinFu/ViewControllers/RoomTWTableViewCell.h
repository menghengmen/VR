//
//  RoomTWTableViewCell.h
//  Blinroom
//
//  Created by Blinroom on 16/10/21.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomTWTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *morebutton;
@property (weak, nonatomic) IBOutlet UILabel *housedes;

@property (weak, nonatomic) IBOutlet UILabel *titlename;
+ (instancetype)detailCell4WithTableView:(UITableView *)tableView;

@end
