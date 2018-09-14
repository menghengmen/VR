//
//  selectHeaderView.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,HOMETYPE) {
   // HomeTypePeople,//个人资料
    HomeTypeCollection,//我的收藏
    HomeTypeBill,//我的订单
};

@interface selectHeaderView : UIView
//收藏的数目
@property(nonatomic,strong)  NSArray  * dataArray;


@property(nonatomic,copy)  void(^selectedBlock)(HOMETYPE type);

/** 下划线 */
@property (nonatomic, weak, readonly)UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) HOMETYPE selectedType;

@end
