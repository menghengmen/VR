//
//  XYBrawerHeaderImageView.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/21.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYImageModel.h"
@interface XYBrawerHeaderImageView : UIImageView
@property (nonatomic,assign) XYPhonesType isPlayer;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) XYImageModel *model;

@property (nonatomic,copy) void(^imageClickBlock)();
@end
