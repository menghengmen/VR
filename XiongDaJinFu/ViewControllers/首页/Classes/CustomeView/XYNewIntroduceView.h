//
//  XYNewIntroduceView.h
//  testDemo
//
//  Created by 威威孙 on 2017/4/30.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYIntroduceItemObj;
typedef NS_ENUM(NSInteger,XYIntrodeceItemType) {
    XYIntrodeceItemTypeRectangle = 1,//矩形
    XYIntrodeceItemTypeRound,//圆形
    XYIntrodeceItemTypeOval,//椭圆
};

@interface XYIntroduceItemObj : NSObject
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,assign) XYIntrodeceItemType type;
@property (nonatomic,assign) CGFloat cornerRadius;
+(instancetype)itemWithRect:(CGRect)rect type:(XYIntrodeceItemType)type cornerRadius:(CGFloat)cornerRadius;
@end

@interface XYNewIntroduceView : UIView
@property (nonatomic,copy) void(^clickBlock)();
+(instancetype)sharedIntroudence;
-(void)showIntroduceWithItems:(NSArray<XYIntroduceItemObj *> *)items;
-(void)hiddenIntroduce;
@end
