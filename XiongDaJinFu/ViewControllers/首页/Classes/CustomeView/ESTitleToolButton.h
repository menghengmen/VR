//
//  ESTitleToolButton.h
//  Essential-New
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTitleToolButton : UIButton

@property (assign, nonatomic) BOOL clicked;///< 表示第三种状态

@property (weak, nonatomic) UIImageView *upArrow;

@property (strong, nonatomic) UIImage *normalImage;///< 正常状态下的image
@property (strong, nonatomic) UIImage *selectedImage; ///< 选中状态下的image

@property (assign, nonatomic) BOOL showDownWhite;///< 是否显示下面的白条
@property (weak, nonatomic) UIView *downWhite;

@end
