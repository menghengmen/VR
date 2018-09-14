//
//  ESPullDownTableView.m
//  Demo
//
//  Created by Alex on 16/3/22.
//  Copyright © 2016年 alexAlex. All rights reserved.
//

#import "ESPullDownTableView.h"

@implementation ESPullDownTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
//        self.rowHeight = 40;
        self.dataSource = self;
        self.delegate = self;
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
//        if (self.cellType == 1) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        }else if (self.cellType == 2){
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//        }else if (self.cellType == 3){
//            cell.textLabel.textAlignment = NSTextAlignmentRight;
//        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithHex:0x666666];
        cell.textLabel.adjustsFontSizeToFitWidth = true;
    }
    
    NSString *str = self.data[indexPath.row];
    cell.textLabel.text = str;
    if ([str rangeOfString:@"(请先选择就读的大学)"].location != NSNotFound) {
        cell.userInteractionEnabled = false;
        cell.textLabel.textColor = [UIColor colorWithHex:0x999999];
    }else{
        cell.textLabel.textColor = [UIColor colorWithHex:0x666666];
        cell.userInteractionEnabled = true;
    }
    
    
    return cell;
}

-(void)setCellType:(NSInteger)cellType{
    _cellType =cellType;
    [self layoutSubviews];
}

- (void)setData:(NSArray *)data {
    _data = data;
    [self reloadData];
}

@end
