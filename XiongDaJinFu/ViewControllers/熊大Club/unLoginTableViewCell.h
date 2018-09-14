//
//  unLoginTableViewCell.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol unLoginDelegate <NSObject>

-(void)didSelectWithBtnTag:(NSUInteger)tag;

@end


@interface unLoginTableViewCell : UITableViewCell


@property (weak, nonatomic)  id<unLoginDelegate>delegate;


@property (strong, nonatomic)  UIButton *registerBtn;

@property (strong, nonatomic)  UIButton *loginBtn;
@end
