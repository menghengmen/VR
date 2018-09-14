//
//  peopleHeadView.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol   peopleHeadViewDelegate<NSObject>


- (void)didClickBtn:(NSString*)btnStr;

@end


@interface peopleHeadView : UIView

@property(nonatomic,weak)  id<peopleHeadViewDelegate>   delegate;

@end
