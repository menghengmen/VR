//
//  CLTextView.h
//  自定义TextView.
//
//  Created by Darren on 16/6/18.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTextView : UITextView
@property (nonatomic, copy) NSString *placehoder;
@property (nonatomic, strong) UIColor *placehoderColor;
@property (nonatomic, weak) UILabel *placehoderLabel;

@end
