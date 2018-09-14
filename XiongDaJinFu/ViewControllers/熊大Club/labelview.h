//
//  labelview.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)(NSInteger index);

@interface labelview : UIView
@property (nonatomic,copy) BtnBlock btnBlock;

-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array;

@property(nonatomic,strong)  NSArray  * dataArray;

@property(nonatomic,strong)  UIButton  * itemBtn;


@end
