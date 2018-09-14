//
//  XYPublishCommentPicCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPublishCommentPicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *array;

@property (nonatomic,copy) void(^getPicBlock)();
@property (nonatomic,copy) void(^deleteBlock)(NSInteger index);
@property (nonatomic,copy) void (^imageSequenceBlock)(NSArray *array);
@end
