//
//  XYPublishCommentPicCollectionCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPublishCommentPicCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commentPic;
@property (nonatomic,assign) NSInteger picType;//1.图片 2.加号
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic,copy) void(^picClickBlock)();
@property (nonatomic,copy) void(^deleteBtnClickBlock)();
- (IBAction)deleteBtnClick:(id)sender;
@end
