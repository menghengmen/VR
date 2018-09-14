//
//  HTStarRatingView.h
//  五星评分－滑动
//
//  Created by gary on 16/2/26.
//  Copyright © 2016年 gary. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(HTStarRatingView *)view score:(float)score;

@end

@interface HTStarRatingView : UIView

@property (nonatomic,weak) id<StarRatingViewDelegate> delegate;

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName withPlace:(CGFloat)place;


/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;


@end

#define kBACKGROUND_STAR @"backgroundStar"
#define kFOREGROUND_STAR @"foregroundStar"
#define kNUMBER_OF_STAR  5


