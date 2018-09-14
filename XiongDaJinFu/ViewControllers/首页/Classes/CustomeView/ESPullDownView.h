//
//  ESPullDownView.h
//  Demo
//
//  Created by Alex on 16/3/22.
//  Copyright © 2016年 alexAlex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ESPullDownSelectBlock)(NSInteger index);

@interface ESPullDownView : UIView

@property (assign, nonatomic) BOOL isShow;

@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSInteger cellType;///<1.居中 2.靠左 3.靠右
@property (copy, nonatomic) ESPullDownSelectBlock clickCallBack;///< 点击回调

+ (instancetype)pullDownView;///< 快速创建
- (void)tagDismiss;
- (void)showFromView:(UIView *)view withData:(NSArray *)data; ///< 显示方法
@end
