//
//  JCTagView.h
//  JCLabel
//
//  Created by room Blin on 2017/3/6.
//  Copyright © 2017年 digirun. All rights reserved.
//


#import <UIKit/UIKit.h>



@protocol tagViewClickNameDelegate <NSObject>

- (void)tagClick:(NSMutableArray*)tagTitleArr;

@end


/**
 *  使用
 *  1.在使用的时候直接创建JCTagView控件，自定义控件的frame (origin,width)高度随着传入的数组的变量变化自适应
 *  2.保留了几个属性 方便使用者定义控件的的背景颜色JCbackgroundColor，JCSignalTagColor
 *  3.在定义好JCTagView控件后，一定要调用 “标签文本这个方法”
 *
 *  
 */

@interface JCTagView : UIView
//底部的黑色背景蒙层
@property (nonatomic,strong) UIView *backgroundView;

@property  (nonatomic,weak)id<tagViewClickNameDelegate>delegate;
@property(nonatomic,strong) NSString*seletedName;
@property(nonatomic,strong)NSMutableArray *selectNameArray;
@property (nonatomic,copy) void(^finshBlock)();
///设置整个View的背景颜色
@property (nonatomic, retain) UIColor *JCbackgroundColor;


/**
 *  设置单一颜色
 */

@property (nonatomic) UIColor *JCSignalTagColor;


/**
 *  标签 文本赋值
 */

- (void)setArrayTagWithLabelArray:(NSArray *)array withMaxSelected:(NSInteger)maX;

@end
