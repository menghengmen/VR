//
//  BaseViewController.h
//  MaDongFrame
//
//  Created by blinroom on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"

typedef void (^userLoginCompletionBlock)(id obj, NSError *error);

typedef void (^refreshDataSourceFunc) (void);
typedef void (^loadMoreDataSourceFunc) (void);

typedef void (^refreshDataSourceCompleted) (void);
typedef void (^loadMoreDataSourceCompleted) (void);

@interface BaseViewController : UMengViewController
<EGORefreshTableHeaderDelegate,
LoadMoreTableFooterDelegate,
UIScrollViewDelegate> {
    UITextField *selectedTextField;
}

//righrBtn
@property(nonatomic,strong)  UIButton  * rightBtn;


//判断刷新还是加载更多
@property (nonatomic) CGPoint currentOffsetPoint;

@property (nonatomic,retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,retain) LoadMoreTableFooterView *loadMoreFooterView;

@property (nonatomic, readonly) BOOL refreshHeaderViewEnabled;
@property (nonatomic, readonly) BOOL loadMoreFooterViewEnabled;

@property (nonatomic) BOOL isRefreshing;
@property (nonatomic) BOOL isLoadingMore;

@property (nonatomic,copy) loadMoreDataSourceFunc loadMoreDataSourceFunc;
@property (nonatomic,copy) refreshDataSourceFunc refreshDataSourceFunc;
@property (nonatomic,copy) refreshDataSourceCompleted refreshDataSourceCompleted;
@property (nonatomic,copy) loadMoreDataSourceCompleted loadMoreDataSourceCompleted;


//下拉刷新控件
- (void)initRefreshHeaderView;
//上拉加载控件
- (void)initLoadMoreFooterView;

- (id)initWithStyle:(UITableViewStyle)style;
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

//未登录提示框
- (void)showLoginAlert:(NSString *)msg;
//错误弹框
- (void)showErrorAlertWithMsg:(NSString *)msg;
//注销
- (void)logout;
//登录
- (void)presentLoginViewControllerWithAnimated:(BOOL)flag
                                    completion:(userLoginCompletionBlock)completion;

//自适应高度/宽度


- (CGRect)getRectWithString:(NSString*)str withFont:(UIFont *)font withWidth:(CGFloat)width withHeight:(CGFloat)height;

//如果图片本身是2进制的NSData形式，那么可以判断第一个字节得出类型：
- (NSString *)typeForImageData:(NSData *)data;

- (UIImage *) createImageWithColor: (UIColor *) color;
- (BOOL)textIsMobileFormat:(NSString *)text;

// Model  View Controller
//创建表格
//- (UITableView *)tableView;

//四舍五入法
- (NSInteger)rounding:(float)point;
//计算汉字的数量，然后再原有字符串长度基础上再加上汉字的数量即可
- (NSInteger)gbk_strlen:(NSString *)text;
//判断字符串内是否仅仅包含汉字，如果是，则返回数组包含匹配的内容，不是则返回空数组
- (BOOL)textIncludeHanziOnly:(NSString *)text;
//支付宝支付
- (void)alipayForOrderWithOrderId:(NSString *)orderSn
                 withSignedString:(NSString *)signedString
                   withNotify_url:(NSString *)notify_url
                 withProductTitle:(NSString *)productTitle
                 withProductsName:(NSString *)productsName
                  withOrderString:(NSString *)orderString
                withProductsPrice:(float)productsPrice;
//判断是否是纯数字
- (BOOL)validateNumber:(NSString*)number;
//适配设置新的frame
- (CGRect)newSuitFrame:(CGRect)frame;

//自定义导航条(黑色背景)
-(void)setUpNewNai:(NSString*)backTitle Title:(NSString*)title;
//自定义导航条(可变背景)

- (void)setUpNewNai:(NSString*)backTitle Title:(NSString*)title withColor:(UIColor*)backColor;

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)bCanDragBack;
- (void)showHint:(NSString *)hint;
-(void)alertWithMessage:(NSString *)message withLittleMessage:(NSString*)littleMessage;
@end
