//
//  XYHourseDetailFacilitiesTBCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define foldLine 2//折叠情况下显示几行
#define itemsInLine 5//每行几个按钮
#define widthInButtons 20 //按钮间距
#define btnWidth (SCREEN_MAIN.width - 2*15 - (itemsInLine -1)*widthInButtons)/itemsInLine
@interface XYHourseDetailFacilitiesTBCell : UITableViewCell
@property (nonatomic,strong) NSArray *facilitieArray;
@property (nonatomic,assign) BOOL isFold;//是否折叠
@property (nonatomic,strong) UIButton *foldButton;
@property (nonatomic,copy) void(^foldBtnClickBlock)(BOOL isFold);

-(CGFloat)getCellHeightWithArray:(NSArray *)modelsArray;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModelsArray:(NSArray *)modelsArray;
@end
