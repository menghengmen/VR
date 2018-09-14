//
//  XYCommentCollectionCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCommentCollectionCell.h"

@implementation XYCommentCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    if (self.imageClickBlock) {
        self.imageClickBlock();
    }
}

@end
