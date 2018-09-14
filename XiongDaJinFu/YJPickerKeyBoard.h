//
//  YJPickerKeyBoard.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJPickerKeyBoardDelegate <NSObject>

@optional
- (void)pickerBoardFinish:(NSString *)selected withData:(NSArray*)dataArray;

@end

@interface YJPickerKeyBoard : UIView

/**
 *  数组包含所有要显示的内容（包括组和行）
 */
@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, weak) UIButton *btn;
//取消按钮
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, strong) UIView *backGroundView;


@property (nonatomic, weak) id<YJPickerKeyBoardDelegate> delegate;
+(YJPickerKeyBoard*)shareInstance;
@end
