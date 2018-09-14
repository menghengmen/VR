//
//  ESTitleToolButton.m
//  Essential-New
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESTitleToolButton.h"

@implementation ESTitleToolButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clicked = false;
        self.exclusiveTouch = true;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        view.hidden = true;
        self.downWhite = view;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        UIColor *normalColor = [UIColor whiteColor];
        UIColor *highlightColor = [UIColor grayColor];
        
//        self.backgroundColor = [UIColor colorWithHex:0xF8F9F7];
        UIImage *normal = [UIImage imageNamed:@"navigationbar_background"];
        UIImage *highlight = [UIImage imageNamed:@"navigationbar_background_selected"];
        
        [self setBackgroundImage:normal forState:UIControlStateNormal];
        [self setBackgroundImage:highlight forState:UIControlStateSelected];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.showDownWhite) {
        _downWhite.hidden = !selected;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (void)setClicked:(BOOL)clicked {
    _clicked = clicked;
    if (clicked) {
        [self setImage:self.normalImage forState:UIControlStateNormal];
    } else {
        [self setImage:nil forState:UIControlStateNormal];
    }
}

- (void)setShowDownWhite:(BOOL)showDownWhite {
    _showDownWhite = showDownWhite;
    
    if (showDownWhite) {
        [self setBackgroundImage:nil forState:UIControlStateSelected];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.centerX = self.width / 2;
    if (self.imageView.image) {
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 3;
    }
    self.downWhite.size = CGSizeMake(40, 1);
    self.downWhite.center = CGPointMake(self.width / 2, self.height - 1);
}

@end
