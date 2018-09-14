//
//  YJTopicCell.h
//  WalkTogether2
//
//  Created by boding on 15/7/29.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTopicModel.h"

@class YJTopicCell;

@protocol  YJTopicCellDelegate <NSObject, UITableViewDelegate>

- (void)topicCell:(YJTopicCell *)topicCell didSelectLable:(NSUInteger)label isPraise:(BOOL)isPraise indexPath:(NSIndexPath *)indexPath;

@end


@interface YJTopicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *imgPanelView;

@property (nonatomic, weak) id<YJTopicCellDelegate> delegate;
@property (nonatomic, strong) MHTopicModel *topic;
@property (nonatomic, strong) MHContentModel *contentTopic;
@property(nonatomic,strong)  MHUserModel  * userModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSArray *imageViewArr;

@end
