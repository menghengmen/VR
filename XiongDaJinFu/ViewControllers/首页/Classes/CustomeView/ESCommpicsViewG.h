//
//  ESCommpicsViewG.h
//  Essential-New
//
//  Created by 奕赏 on 16/3/12.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ESCommpicsViewG : UIView
@property (nonatomic,strong)NSArray *picsPathArray;
@property (nonatomic,copy)void(^imageViewClickBlock)(NSInteger imageIndex,NSArray *picsUrlArray,UIImageView *imageView,NSMutableArray *picArray);
//-(void)setImaegsWithModel:(ESCommunityGroupsModelG *)model;

@end
