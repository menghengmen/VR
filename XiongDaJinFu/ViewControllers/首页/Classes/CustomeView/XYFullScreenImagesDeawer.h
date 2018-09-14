//
//  XYFullScreenImagesDeawer.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/17.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYFullScreenImagesDeawer : UIImageView
@property (assign, nonatomic) NSInteger currentIndex;
@property (nonatomic,assign) BOOL isInScreen;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) NSArray *titlesArray;

@property (copy, nonatomic) void(^getScrollViewIndexBlock)(NSInteger index);

//@property (nonatomic,copy) void(^imageTapBlock)();
+(instancetype)sharedImageBrawer;
-(void)showImageBrawerWithDataArray:(NSArray *)dataArray andCurrentIndex:(NSInteger)currentIndex andBegainRect:(CGRect)begainRect;
-(void)removeSelf1;
@end
