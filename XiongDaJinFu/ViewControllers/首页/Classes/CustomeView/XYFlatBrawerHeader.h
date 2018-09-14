//
//  XYFlatBrawerHeader.h
//  testDemo
//
//  Created by 威威孙 on 2017/3/21.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYFlatBrawerHeader;
@protocol FlatDrawerDelegate<NSObject>;
@optional
-(NSInteger)numOfSectionsInDrawer:(XYFlatBrawerHeader *)flatBrawerHeader;
-(NSInteger)flatBrawerHeader:(XYFlatBrawerHeader *)flatBrawerHeader numOfIntemsInSection:(NSInteger)sectionIndex;
-(NSArray *)titlesOfFlatBrawer:(XYFlatBrawerHeader *)flatBrawerHeader;
@required
-(UIImageView *)flatBrawerHeader:(XYFlatBrawerHeader *)flatBrawerHeader itemForHeaderAtIndex:(NSInteger)index;
@end
@interface XYFlatBrawerHeader : UIView

@property (nonatomic,strong) UIScrollView *picsScrollView;
@property (nonatomic,strong) UIScrollView *titlesScrollView;
@property (nonatomic,assign) NSInteger currentPictureIndex;
@property (nonatomic,weak)   id<FlatDrawerDelegate> delegate;

-(void)reloadData;
@end
