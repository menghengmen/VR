//
//  ViewController.h
//  XiongDaJinFu
//
//  Created by blinRoom on 16/10/13.
//  Copyright © 2016年 blinRoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UMengTableViewController
/**
 *  无限轮播标题的数组
 */
@property (nonatomic, strong) NSMutableArray *imageTitleArray;
/**
 *  无限轮播要使用的数组
 */
@property (nonatomic, strong) NSMutableArray *bannerImageArray;

/**
 *  真实数量的图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;


/**
 *  真实数量的标题数组
 */
@property (nonatomic, strong) NSMutableArray *blinTitleArr;




/**
 *  热门房源
 */
@property (nonatomic, strong) NSMutableArray *hotHouseArray;

/**
 *  热门咨询
 */
@property (nonatomic, strong) NSMutableArray *ziXunArray;

/**
 *  比邻客
 */
@property (nonatomic, strong) NSMutableArray *blinKeArray;


@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

//轮播图的图片
@property(strong, nonatomic)NSArray * imagesURLStrings;
@property(strong, nonatomic)UICollectionView * hotCollection;






@end

