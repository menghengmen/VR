//
//  CLTextView.m
//  自定义TextView.
//
//  Created by Darren on 16/6/18.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLTextView.h"
@interface CLTextView() <UITextViewDelegate>
@end

@implementation CLTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTexiView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupTexiView];
}

- (void)setupTexiView
{
    self.backgroundColor = [UIColor clearColor];
    
    // 添加一个显示提醒文字的label（显示占位文字的label）
    UILabel *placehoderLabel = [[UILabel alloc] init];
    placehoderLabel.numberOfLines = 0;
    placehoderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:placehoderLabel];
    self.placehoderLabel = placehoderLabel;
    
    // 设置默认的占位文字颜色
    self.placehoderColor = [UIColor lightGrayColor];
    
    // 设置默认的字体
    self.font = [UIFont systemFontOfSize:14];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
}

#pragma mark - 公共方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    // 设置文字
    self.placehoderLabel.text = placehoder;

    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    // 设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.placehoderLabel.frame;
    frame.origin.y = 8;
    frame.origin.x = 5;
    frame.size.width = self.frame.size.width - 2 * frame.origin.x;
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.frame.size.width, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize];
    frame.size.height = placehoderSize.height;
    self.placehoderLabel.frame = frame;
}

@end
