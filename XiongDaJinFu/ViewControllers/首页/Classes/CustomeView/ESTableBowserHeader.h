//
//  ESTableBowserHeader.h
//  Essential-New
//
//  Created by 奕赏 on 16/9/5.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTableBowserHeader : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *pictureUrlArray;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) BOOL isInScreen;

@property (copy, nonatomic) void(^HeaderClickBlock)(NSInteger index);

@end
