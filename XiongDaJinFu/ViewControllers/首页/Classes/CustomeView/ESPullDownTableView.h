//
//  ESPullDownTableView.h
//  Demo
//
//  Created by Alex on 16/3/22.
//  Copyright © 2016年 alexAlex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPullDownTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) NSInteger cellType;

@end
