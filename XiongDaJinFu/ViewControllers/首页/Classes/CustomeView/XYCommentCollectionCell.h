//
//  XYCommentCollectionCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCommentCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (nonatomic,copy) void(^imageClickBlock)();
@end
