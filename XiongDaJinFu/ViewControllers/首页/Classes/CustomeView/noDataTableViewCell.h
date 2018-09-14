//
//  noDataTableViewCell.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/25.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pushListDelegate <NSObject>

-(void)didPushListBtn;

@end
@interface noDataTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *noDataBtn;

@property  (nonatomic,weak)  id<pushListDelegate>  delegate;


@end
