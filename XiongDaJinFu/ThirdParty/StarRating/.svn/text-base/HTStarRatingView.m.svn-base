//
//  HTStarRatingView.m
//  五星评分－滑动
//
//  Created by gary on 16/2/26.
//  Copyright © 2016年 gary. All rights reserved.
//

#import "HTStarRatingView.h"
@interface HTStarRatingView (){
    UIImage *deselectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
}

@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;
/**
 *评分是否可点击滑动，YES不可点击滑动，NO可以
 */
@property (assign,nonatomic)BOOL isAnimate;
@end

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@implementation HTStarRatingView




-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName withPlace:(CGFloat)place{
    
    deselectedImage = [UIImage imageNamed:deselectedName];
    halfSelectedImage = halfSelectedName == nil ? deselectedImage : [UIImage imageNamed:halfSelectedName];
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    
    _s1 = [[UIImageView alloc] initWithImage:deselectedImage];
    _s2 = [[UIImageView alloc] initWithImage:deselectedImage];
    _s3 = [[UIImageView alloc] initWithImage:deselectedImage];
    _s4 = [[UIImageView alloc] initWithImage:deselectedImage];
    _s5 = [[UIImageView alloc] initWithImage:deselectedImage];
    
    CGFloat sWidth = WIDTH - place;
    [_s1 setFrame:CGRectMake(0,          0, sWidth *0.2, HEIGHT)];
    [_s2 setFrame:CGRectMake(sWidth *0.2+place/4, 0, sWidth *0.2, HEIGHT)];
    [_s3 setFrame:CGRectMake(sWidth *0.4+place/2, 0, sWidth *0.2, HEIGHT)];
    [_s4 setFrame:CGRectMake(sWidth *0.6+place*3/4, 0, sWidth *0.2, HEIGHT)];
    [_s5 setFrame:CGRectMake(sWidth *0.8+place, 0, sWidth *0.2, HEIGHT)];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
    
}

#pragma mark -
#pragma mark - Set Score

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate
{
    self.isAnimate = isAnimate;
    
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^
     {
         [weakSelf displayRatingWithScore:score];
     }];
    
}

#pragma mark -
#pragma mark - Touche Event
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isAnimate) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        [self changeStarScoreWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isAnimate) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^
     {
         [weakSelf changeStarScoreWithPoint:point];
     }];
}

#pragma mark -
#pragma mark - Change Star Score With Point

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarScoreWithPoint:(CGPoint)point
{
    
    if (point.x < 0)
    {
        point.x = 0;
    }
    
    if (point.x > self.frame.size.width)
    {
        point.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",point.x / self.frame.size.width];
    float score = [str floatValue] *10;
    
    
    NSInteger intScore = score/2;
    
    [self displayRatingWithScore:score];
    
    //传值
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:intScore];
    }
}

#pragma mark -
#pragma mark - Set Image
/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
-(void)displayRatingWithScore:(float)score{
    [_s1 setImage:deselectedImage];
    [_s2 setImage:deselectedImage];
    [_s3 setImage:deselectedImage];
    [_s4 setImage:deselectedImage];
    [_s5 setImage:deselectedImage];
    
    if (score >= 1) {
        [_s1 setImage:halfSelectedImage];
    }
    if (score >= 2) {
        [_s1 setImage:fullSelectedImage];
    }
    if (score >= 3) {
        [_s2 setImage:halfSelectedImage];
    }
    if (score >= 4) {
        [_s2 setImage:fullSelectedImage];
    }
    if (score >= 5) {
        [_s3 setImage:halfSelectedImage];
    }
    if (score >= 6) {
        [_s3 setImage:fullSelectedImage];
    }
    if (score >= 7) {
        [_s4 setImage:halfSelectedImage];
    }
    if (score >= 8) {
        [_s4 setImage:fullSelectedImage];
    }
    if (score >= 9) {
        [_s5 setImage:halfSelectedImage];
    }
    if (score == 10) {
        [_s5 setImage:fullSelectedImage];
    }
    
}
@end
