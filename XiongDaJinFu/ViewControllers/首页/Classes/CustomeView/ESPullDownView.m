//
//  ESPullDownView.m
//  Demo
//
//  Created by Alex on 16/3/22.
//  Copyright © 2016年 alexAlex. All rights reserved.
//

#import "ESPullDownView.h"
#import "ESPullDownTableView.h"

@interface ESPullDownView () <UITableViewDelegate>

@property (weak, nonatomic) ESPullDownTableView *tableView;

@property (strong, nonatomic) UIView *bg;

@property (weak, nonatomic) UIView *fromView;

@property (weak, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation ESPullDownView

+ (instancetype)pullDownView {
    ESPullDownView *_pullDown = [[ESPullDownView alloc] init];
    return _pullDown;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isShow = false;
        self.backgroundColor = [UIColor redColor];
        self.alpha = 1;
        ESPullDownTableView *table = [[ESPullDownTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.cellType =self.cellType;
        table.delegate = self;
        [self addSubview:table];
        self.tableView = table;
    }
    return self;
}
#pragma mark - setter getter
- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.width, SCREEN_MAIN.height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDismiss)];
        [_bg addGestureRecognizer:tap];
    }
    return _bg;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator = indicator;
        [self addSubview:indicator];
    }
    return _indicator;
}

- (void)showFromView:(UIView *)view withData:(NSArray *)data {
    
    if (!view) {
        return;
    }
    self.fromView = view;
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    CGPoint newPoint = [view convertPoint:CGPointMake(0, CGRectGetMaxY(view.bounds)) toView:widow];
    
    [widow addSubview:self.bg];
    [widow addSubview:self];
    if (data.count == 0) {
        self.frame = CGRectMake(newPoint.x, newPoint.y, view.frame.size.width, 40);
        
        self.indicator.frame = CGRectMake(self.frame.size.width / 2 - 20, 0, 40, 40);
        [self.indicator startAnimating];
    } else {
        
        self.frame = CGRectMake(newPoint.x-1, newPoint.y, view.frame.size.width +2, data.count * 40);
        if (self.height > SCREEN_MAIN.height - 44 - newPoint.y) {
            self.height = SCREEN_MAIN.height - 44 - newPoint.y;
        }
    }
    //展现动画
    CGPathRef beginPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, 0)].CGPath;
    CGPathRef endPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)].CGPath;
    self.tableView.data = data;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = beginPath;
    
    self.layer.mask = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = kAnimateTime;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (id)layer.path;
    animation.toValue = (__bridge id _Nullable)(endPath);
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"shapeLayerPath"];
    self.isShow = true;
}

- (void)tagDismiss {
    ((UIButton *)self.fromView).selected = false;
    [UIView animateWithDuration:kAnimateTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bg removeFromSuperview];
        self.isShow = false;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self tagDismiss];
    if (self.clickCallBack) {
        self.clickCallBack(indexPath.row);
    }
}

@end
