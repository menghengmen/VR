//
//  XYHourseSiftHeader.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYHourseSiftHeader : UIView

//@property (weak, nonatomic) IBOutlet UISegmentedControl *countrySegment;
@property (weak, nonatomic) IBOutlet UIButton *UKBtn;
@property (weak, nonatomic) IBOutlet UIButton *USABtn;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderViewLeftMargin;
- (IBAction)openBtnClick:(id)sender;
- (IBAction)btnClick:(UIButton *)sender;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,copy) void(^segmentClickBlock)(NSInteger index);
@property (nonatomic,copy) void(^openBtnClickBlock)(BOOL isOpen);
@end
