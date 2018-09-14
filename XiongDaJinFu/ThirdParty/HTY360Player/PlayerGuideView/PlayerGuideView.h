//
//  PlayerGuideView.h
//  VR800
//
//  Created by Peng Sheng on 16/3/31.
//  Copyright © 2016年 Peng Sheng. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol PlayGuideViewDelegate
- (void)guideDidEnd;
@end
@interface PlayerGuideView : UIView
@property(weak)id<PlayGuideViewDelegate> delegate;
@property(assign)int kind;
- (void)animationBegin:(int)kind;
@end
