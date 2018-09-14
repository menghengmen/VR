//
//  searchUniversityView.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/11.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityModel.h"
@class  UniversityModel;
@class  majorModel;
@protocol searchUniversityDelegate <NSObject>

- (void)didSelectUniversity:(UniversityModel *)University;

- (void)didSelectMajor:(majorModel *)major;

@optional

@end


@interface searchUniversityView : UIView
//类型,区分大学专业
@property(nonatomic,strong)  NSString  * typeStr;

+(searchUniversityView*)shareInstance;

@property (nonatomic,copy) void(^finishBlock)();
@property(nonatomic,weak)   id<searchUniversityDelegate>delegate;

/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;



//底部的黑色背景蒙层
@property (nonatomic,strong) UIView *backgroundView;


- (void)initViewWithData:(NSArray*)dataArray;

-(void)disiss;
@end
