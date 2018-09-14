//
//  YJItemView.m
//  WalkTogether
//
//  Created by gary on 16/12/8.
//  Copyright © 2016年 digirun. All rights reserved.
//


#import "YJItemView.h"

#define kWdith 40
#define kTag68 68

@implementation YJItemView

- (void)setNameArray:(NSArray *)nameArray
{
    _nameArray = nameArray;
//
//    int j = 0;
//    NSArray *array = self.subviews;
//    for (int i = 0; i < array.count; i++) {
//        UIView *view = array[i];
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel *)view;
//            label.text = nameArray[j++];
//        }
//    }
     CGFloat wdith = kWdith/320.0*self.frame.size.width;
     CGFloat magin = (self.frame.size.width - _nameArray.count * wdith) /(_nameArray.count *2);
    
    for (int i = 0; i < _nameArray.count ; i++) {
        CGFloat x = self.frame.size.width/_nameArray.count*i+magin;
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, kWdith, kWdith)];
//        button.tag = (1 + i) * kTag68;
//        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//
//        [self addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, wdith, wdith+0, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = nameArray[i];
        [self addSubview:label];
    }

    
    
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    CGFloat wdith = kWdith/320.0*self.frame.size.width;
    CGFloat magin = (self.frame.size.width - _imageArray.count * wdith) / (_imageArray.count*2);
    
    for (int i = 0; i < _imageArray.count; i++) {
        CGFloat x = self.frame.size.width/_imageArray.count*i+magin;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, wdith, wdith)];
        button.tag = (1 + i) * kTag68;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:_imageArray[i] forState:UIControlStateNormal];
        [self addSubview:button];
        
    }

    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        
    }
    return self;
}

#pragma mark - action
- (void)btnClick:(UIButton *)sender
{
    // 根据tag区分
    if ([self.delegate respondsToSelector:@selector(itemViewBtnClickWithitemView:tag:name:)]) {
        [self.delegate itemViewBtnClickWithitemView:self tag:sender.tag name:_nameArray[sender.tag/kTag68-1]];
    }
}

@end
