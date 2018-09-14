//
//  SelectLabelViw.h
//  Blinroom
//
//  Created by Blinroom on 16/8/16.
//  Copyright © 2016年 Blinroom. All rights reserved.
//
#import <UIKit/UIKit.h>



@interface SelectLabelView : UIView

@property (nonatomic, strong) NSMutableArray *allLabels;//元素为 按钮 ，外部遍历该数组，取按钮的 select 属性，当为yes是则表示是已选的标签，按钮的tag值为 标签ID，用于提交
@property(nonatomic,strong) NSString*seletedname;
@property(nonatomic,strong)NSMutableArray *slenamearray;
// max 传入0 的时候 表示 只显示，无法选择，用于评价成功后显示的界面
-(id)initWithLabelNamesArray:(NSArray*)labelnames andMaxSelect:(NSInteger)max andStartY:(CGFloat)startY;

@end
