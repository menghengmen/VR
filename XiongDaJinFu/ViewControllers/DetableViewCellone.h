//
//  DetableViewCellone.h
//  Blinroom
//
//  Created by Blinroom on 16/8/10.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetableViewCellone : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Chatlabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *viewbutton;

@property (weak, nonatomic) IBOutlet UILabel *Citylabel;

@property (weak, nonatomic) IBOutlet UILabel *Postcodelabel;
@property (weak, nonatomic) IBOutlet UILabel *Roomlabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberoom;
@property (weak, nonatomic) IBOutlet UILabel *startoend;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *price3;
@property (weak, nonatomic) IBOutlet UILabel *tltlename;
+ (instancetype)detailViewCellTableView:(UITableView *)tableView;

@end
