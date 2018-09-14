//
//  YJItemView.h
//  WalkTogether
//
//  Created by gary on 16/12/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJItemView;

@protocol YJItemViewDelegate <NSObject>

@optional
- (void)itemViewBtnClickWithitemView:(YJItemView *)itemView tag:(NSInteger)tag name:(NSString *)buttonName;

@end

@interface YJItemView : UIView

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, weak) id<YJItemViewDelegate> delegate;

@end
