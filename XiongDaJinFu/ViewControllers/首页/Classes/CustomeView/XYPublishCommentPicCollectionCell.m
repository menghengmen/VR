//
//  XYPublishCommentPicCollectionCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYPublishCommentPicCollectionCell.h"

@implementation XYPublishCommentPicCollectionCell
{
    UITapGestureRecognizer *_tap;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commentPic.userInteractionEnabled = true;
    self.commentPic.clipsToBounds = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    _tap = tap;
    [self.commentPic addGestureRecognizer:tap];
}

-(void)tap:(UITapGestureRecognizer *)tap{
    if (self.picClickBlock) {
        self.picClickBlock();
    }
}

-(void)setPicType:(NSInteger)picType{
    _picType = picType;
    if (picType == 1) {
        self.deleteBtn.hidden = false;
        _tap.enabled = false;
    }else if(picType == 2){
        self.deleteBtn.hidden = true;
        _tap.enabled = true;
    }
}

- (IBAction)deleteBtnClick:(id)sender {
    if (self.deleteBtnClickBlock) {
        self.deleteBtnClickBlock();
    }
}
@end
