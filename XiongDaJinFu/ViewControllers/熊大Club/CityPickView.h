//
//  CityPickView.h
//  cityPickView
//
//  Created by room Blin on 2017/3/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)(NSString *proVince,NSString *city,NSString *area);
typedef void(^selectOver)(NSString *proVince,NSString *city,NSString *area);
typedef void(^cancelBlock)();

@interface CityPickView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>

@property (copy,nonatomic) NSString *province;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *area;

@property (copy,nonatomic) NSString *address;

@property (nonatomic,assign) BOOL toolshidden;

@property (copy,nonatomic) confirmBlock confirmblock;
@property (copy,nonatomic) cancelBlock cancelblock;
@property (copy,nonatomic) selectOver doneBlock;
//背景
@property(nonatomic,strong)  UIView  * backGroundView;

- (void)setContentPath:(NSString*)content;
@end
