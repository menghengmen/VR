//
//  XYCommentTableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCommentModel.h"
@interface XYCommentTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
//<CommentPicsViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerIamgeView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteBtnHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *yeaLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *picsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,copy) void(^deleteBtnCLickBlock)();

@property (nonatomic,copy) void(^imageClickBlock1)(NSInteger index,CGRect rect);

@property (nonatomic,strong) XYCommentModel *model;
- (IBAction)deleteBtnClick:(UIButton *)sender;

//@property (nonatomic,strong) NSArray *modelsArray;
@end
