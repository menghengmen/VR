//
//  searchView.h
//  DCWebPicScrollView
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 name. All rights reserved.
//

#import <UIKit/UIKit.h>
@class city;


@protocol searchViewDelegate <NSObject>

- (void)didSelectCity:(city *)city;
@optional

@end

@interface searchView : UIView


@property(nonatomic,weak)   id<searchViewDelegate>delegate;

- (void)initViewWithData:(NSArray*)dataArray;
@end
