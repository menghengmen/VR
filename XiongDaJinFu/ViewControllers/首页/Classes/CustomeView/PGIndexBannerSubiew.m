//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self addSubview:self.allCoverButton];
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.layer.cornerRadius = 6;
        _mainImageView.layer.shadowRadius=5;
        //_mainImageView.layer.masksToBounds = YES;
   
      
    
        _mainImageView.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        _mainImageView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        _mainImageView.layer.shadowOpacity = YES;
    
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor clearColor];
       
    }
    return _coverView;
}

- (UIButton *)allCoverButton {
    if (_allCoverButton == nil) {
        _allCoverButton = [[UIButton alloc] initWithFrame:self.bounds];
        _allCoverButton.clipsToBounds = YES;
        _allCoverButton.layer.cornerRadius = 6;
        _allCoverButton.layer.shadowColor=[UIColor redColor].CGColor;
        _allCoverButton.layer.shadowOffset=CGSizeMake(10, 10);
        _allCoverButton.layer.shadowRadius=5;
        _allCoverButton.layer.masksToBounds = NO;
//        _allCoverButton.layer.borderWidth = 1;
//        _allCoverButton.layer.borderColor = [[UIColor colorWithHexString:@"#000000"] CGColor];
//   
    
        _allCoverButton.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        _allCoverButton.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        _allCoverButton.layer.shadowOpacity = 1;

    }
    return _allCoverButton;
}

@end
