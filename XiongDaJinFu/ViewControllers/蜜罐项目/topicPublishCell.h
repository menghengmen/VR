//
//  topicPublishCell.h
//  WalkTogether2
//
//  Created by gw on 16/3/30.
//  Copyright © 2016年 GYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxImageCount 6

@protocol topicPublishCellDelegate <NSObject>

- (void)itemClickWithIndex:(NSIndexPath *)indexPath;


@end

@interface topicPublishCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *inputContent;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, weak) id<topicPublishCellDelegate> delegate;

- (void)refreshCollectionView:(NSMutableArray *)arr;

@end
