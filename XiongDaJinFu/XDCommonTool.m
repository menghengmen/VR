////
//  XDCommonTool.m
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "XDCommonTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "HomePageViewController.h"
#import "HoneyBottleViewController.h"
#import "MyAccountViewController.h"
#import "CustomNavigationController.h"
#import "commonViewController.h"
#import "NSMutableArray+ND.h"
#import "XYSettingInfoModel.h"

@interface XDCommonTool()<TDAlertViewDelegate>

@end
@implementation XDCommonTool

+(UIWindow *)window{
    
    
    return [[[UIApplication sharedApplication]delegate]window];
    
    
    
}
+ (void)goToMain{

    //首页
    HomePageViewController *homeview=[[HomePageViewController alloc]init];
    homeview.tabBarItem.image=[UIImage imageNamed:@"icon_tab_person"];
    homeview.tabBarItem.title=@"首页";
    

  
    //分类
    HoneyBottleViewController *BottleView=[[HoneyBottleViewController alloc]init];
    BottleView.tabBarItem.image=[UIImage imageNamed:@"icon_tab_person"];
    BottleView.tabBarItem.title=@"大学";
    

   
    //我的
    MyAccountViewController *MyAccountView=[[MyAccountViewController alloc]init];
    MyAccountView.tabBarItem.image=[UIImage imageNamed:@"icon_tab_person"];
    MyAccountView.tabBarItem.title=@"我的";
    
    UITabBarController  * tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = @[homeview,BottleView,MyAccountView];

   
    
    CustomNavigationController  * navi = [[CustomNavigationController alloc] initWithRootViewController:tabBar];
    
    self.window.rootViewController=navi;


}


//邮箱地址的正则表达式
+(BOOL)checkEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  正则表达式检验手机号
 */
+ (BOOL)checkTel:(NSString *)str
{
    
    if ([str length] == 0) {
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,1,2,3,5-9]))\\d{8}$";
    NSString *regex =@"^[1]((3|5|7|8)\\d{1})\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
    
}

/**
 *  保存BOOL型数据到UserDefault
 */
+ (void)saveToUserDefaultWithBool:(BOOL)value key:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

/**
 *  从UserDefault读取BOOL型数据
 */
+ (BOOL)readBoolFromUserDefaultWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL result = [defaults boolForKey:key];
    
    return result;
}

/**
 *  保存NSString型数据到UserDefault
 */
+ (void)saveToUserDefaultWithString:(NSString *)value key:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

/**
 *  从UserDefault读取NSString型数据
 */
+ (NSString *)readStringFromUserDefaultWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result = [defaults stringForKey:key];
    
    return result;
}
/**
 *  保存NSDictionary型数据到UserDefault
 */
+ (void)saveToUserDefaultWithDic:(NSDictionary *)value key:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted    error:nil];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

/**
 *  从UserDefault读取NSDictionary型数据
 */
+ (NSDictionary *)readDicFromUserDefaultWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData  *data = [defaults  dataForKey:key];
    if (!data) {
        return nil;
    }
    
    NSDictionary *result = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return result;
}

/**
 *  删除某个存储的元素
 */
+ (void)removeIdForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:key];
    
    [defaults synchronize];
}


/**
 *  根据相应信息弹出一个AlertView，适合点击按钮后不采取其他操作的情况
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sure
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:sure otherButtonTitles:nil];
    [alert show];
}

+ (BOOL)isLogin
{
    NSString *isLogin = [XDCommonTool readStringFromUserDefaultWithKey:kIsLogin];
    return [isLogin isEqualToString:@"true"];
    //    return YES;
}


//tabBar的高度
+ (CGFloat)tabBarHeight
{
    return SCREENHEIGHT * 0.09167;
}

+ (NSString *)getURLStringWithString:(NSString *)aString
{
    NSString *urlString;
    NSString *firstChar = [aString substringToIndex:1];
    if ([firstChar isEqualToString:@"/"]) {
        urlString = [NSString stringWithFormat:@"%@%@", globalURL, aString];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", globalURL, aString];
    }
    
    return urlString;
}
+(NSString *)getDateFormatterWithDate:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [fmt stringFromDate:date];
    return dateString;
}
//时间戳转NSDate
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+(NSDate*)getDateFromString:(NSString*)dateStr{

    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSDate * stringDate = [fmt dateFromString:dateStr];
    return stringDate;


}

+(NSString *)changeDate:(NSDate *)date withFormatter:(NSString *)format
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fmt setDateFormat:format];
    NSString *dateString = [fmt stringFromDate:date];
    return dateString;
}
+(NSString *)getFromDateString:(NSString *)string withStringFormatter:(NSString *)format andchangeFormat:(NSString *)aimFormat
{
    NSDateFormatter *fmt1 = [[NSDateFormatter alloc]init];
    NSDateFormatter *fmt2 = [[NSDateFormatter alloc]init];
    
    [fmt1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fmt2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fmt1 setDateFormat:format];
    [fmt2 setDateFormat:aimFormat];
    NSDate *date = [fmt1 dateFromString:string];
    NSString *dateString = [fmt2 stringFromDate:date];
    return dateString;
}
+(NSDate *)getNow
{
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [NSDate dateWithTimeIntervalSinceNow:interval];
}


+(void)alertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

+(void)alertWithMessage:(NSString *)message withLittleMessage:(NSString*)littleMessage{

    TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
    
    TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
    item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
    item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
    TDAlertView *alert = [[TDAlertView alloc] initWithTitle:message message:littleMessage items:@[item1,item2] delegate:self];
    alert.hideWhenTouchBackground = NO;
    
    [alert show];
}
-(void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex{    LRLog(@"点击了%ld",(long)itemIndex);
}
+(NSMutableArray *)getArrayWithKey:(NSString *)key fromArray:(NSMutableArray *)array
{
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (id dic in array) {
        [returnArray addObject:[dic valueForKey:key]];
    }
    return returnArray;
}

+(void)showMessage:(NSString *)message inView:(UIView *)view
{
    //    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //    UIView *showview =  [[UIView alloc]init];
    //    showview.backgroundColor = [UIColor blackColor];
    //    showview.frame = CGRectMake(1, 1, 1, 1);
    //    showview.alpha = 1.0f;
    //    showview.layer.cornerRadius = 5.0f;
    //    showview.layer.masksToBounds = YES;
    //    [window addSubview:showview];
    //
    //    UILabel *label = [[UILabel alloc]init];
    //    CGSize LabelSize =  [message boundingRectWithSize:CGSizeMake(290, 9000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 ]} context:nil].size;
    //    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    //    label.text = message;
    //    label.textColor = [UIColor whiteColor];
    //    label.textAlignment = 1;
    //    label.backgroundColor = [UIColor clearColor];
    //    label.font = [UIFont boldSystemFontOfSize:15];
    //    [showview addSubview:label];
    //    showview.frame = CGRectMake((globalRect.size.width - LabelSize.width - 20)/2, globalRect.size.height - 100, LabelSize.width+20, LabelSize.height+10);
    //    [UIView animateWithDuration:1.5 animations:^{
    //        showview.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        [showview removeFromSuperview];
    //    }];
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    hud.labelText =message;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    //    __weak typeof(view) weakView = view;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.0);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    
}
/**
* 字串MD5 加密
* @Param
* @Return
*/
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * 转码unicode 除数字和字母
 * @Param
 * @Return
 */
+(NSString*) escapedStringAll:(NSString*)unescaped
{
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef) unescaped,
                                                                                                    NULL,
                                                                                                    CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                                    kCFStringEncodingUTF8));
    return escapedString;
}

/**
 * hmacsha1 算法
 * @Param
 * @Return
 */
- (NSString *) hmacSha1:(NSString*)key text:(NSString*)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}

//计算单个文件大小

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//计算目录大小

+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSLog(@"fileName   %@", fileName);
            if ([fileName isEqualToString:@"default"]) {
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                folderSize +=[XDCommonTool fileSizeAtPath:absolutePath];
            }
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
//清理缓存文件

//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。

+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSLog(@"fileName1   %@", fileName);
            //如有需要，加入条件，过滤掉不想删除的文件
           // if ([fileName isEqualToString:@"default"]) {
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
           // }
            
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

//判断当前的网络是3g还是wifi

+ (void)reachability
{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    GlobalObject * globe = [GlobalObject shareInstance];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 // 回调处理
                 break;
             default:
                 break;
         }
         globe.networkStatus = status;
     }];
}

//文件写入沙盒

+ (BOOL)writeFileToSandBoxWithFileName:(NSString*)fileName  withData:(id)object{

     BOOL  is_Success=  [object writeToFile:[self getFilePath:fileName] atomically:YES];
    
    return is_Success;
    
}

#pragma mark--获得文件的路径方法
+(NSString *)getFilePath:(NSString *)fileName
{
    //    获得Documnets路径
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [pathArray objectAtIndex:0];
    
    
    NSString *newFilePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    LRLog(@"所有大学的配置项%@",newFilePath);
    //[CommonTool saveToUserDefaultWithString:newFilePath key:@"newFilePath"];
    return newFilePath;
}

/**
 *  根据id查询沙盒中的数据
 
 *
 *  @param cityIdStr    城市的id
 *  @param  typeStr     文件的名字 (城市或大学的区分)
 *  @return         NSMutableArray 查询的数据
 */
+ (NSMutableArray*)queryDataWithID:(NSString*)cityIdStr withType:(NSString*)typeStr{

    NSMutableArray  * cityArr = [NSMutableArray new];
    
    NSString* pathStr =   [self getFilePath:typeStr];
    
    NSArray  * dataArr = [[NSArray alloc] init];
    if ([typeStr isEqualToString:@"allAddress.plist"]) {
        dataArr = [[[[NSDictionary dictionaryWithContentsOfFile:pathStr] objectForKey:@"result"] firstObject] objectForKey:@"child"];
    }
    else{
    
     dataArr = [[NSDictionary dictionaryWithContentsOfFile:pathStr] objectForKey:@"result"] ;
    }
    
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       NSString  * idStr = [[obj objectForKey:@"id"] stringValue];
   
       if ([cityIdStr isEqualToString:idStr]) {
           [cityArr addObject:[obj objectForKey:@"name_zh"]];
       }
   
   
   }];


    return cityArr;
    


}
+(NSMutableArray*)queryPeiZhiWithKey:(NSString*)key withIdOrName:(NSString*)name  withType:(NSString*)type{

    NSMutableArray  * peiZhiArr = [NSMutableArray new];
    
    NSMutableArray *arr  = [NSMutableArray array];
    NSDictionary  * peiZhiDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath:@"allDictionary.plist"]];
    
    NSArray  * dataArray = [peiZhiDict objectForKey:@"result"];
    for (NSDictionary *dict in dataArray) {
        if ([dict[@"alias"] isEqualToString:key]) {
            arr = dict[@"child"];
        }
    }
   
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([type isEqualToString:@"id"]) {
            NSString  * idStr = [obj objectForKey:@"alias"] ;
            
            if ([name isEqualToString:idStr]) {
                [peiZhiArr addObject:[obj objectForKey:@"name_zh"]];
            }
            
        }
        
        else{
            NSString  * idStr = [obj objectForKey:@"name_zh" ];
            
            if ([name isEqualToString:idStr]) {
                [peiZhiArr addObject:[obj objectForKey:@"alias"]];
            }
            

    
        }
    
    }];
    
    return peiZhiArr;

}


+ (NSMutableArray*)queryUniversityDataWithID:(NSString*)universityIdStr withType:(NSString*)type;
{
    NSMutableArray  * universityArr = [NSMutableArray new];
    
    NSString* pathStr =   [self getFilePath:@"allUniversity.plist"];

    NSArray *  dataArr = [[NSDictionary dictionaryWithContentsOfFile:pathStr] objectForKey:@"result"] ;
   
   [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       if ([type isEqualToString:@"id"]) {
           NSString  * idStr = [[obj objectForKey:@"id"] stringValue];
           
           if ([universityIdStr isEqualToString:idStr]) {
               [universityArr addObject:[obj objectForKey:@"name_zh"]];
           }

       }
       
       else{
           NSString  * idStr = [obj objectForKey:@"name_zh" ];
           
           if ([universityIdStr isEqualToString:idStr]) {
               [universityArr addObject:[obj objectForKey:@"id"]];
           }
       
       
       
       }
  
   
   
   
   }];




    return universityArr;
}

/**
 *  取本地配置项
 *
 *  @param fileName   文件名
 *  @param keyStr    主键
 *  @return return NSMutableArray 取到的配置项
 */
+ (NSMutableArray*)getPeiZhiWithFileName:(NSString*)fileName keyStr:(NSString*)keyStr{

   
    NSMutableArray  * resultArray = [NSMutableArray new];
    
    NSDictionary  * peiZhiDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath:fileName]];

    NSArray  * dataArray = [peiZhiDict objectForKey:@"result"];

   [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if ([keyStr isEqualToString:[obj objectForKey:@"alias"]]) {
        NSArray  * childArr =  [obj objectForKey:@"child"];
         [childArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [resultArray addObject:[obj objectForKey:@"name_zh"]];
         }];
      
       
     
       }
  
   
  
   
   }];
   
    
    
    return resultArray;
}

+(NSArray *)getSettingInfoWithKey:(NSString *)key{
    NSMutableArray *arr  = [NSMutableArray array];
    NSDictionary  * peiZhiDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath:@"allDictionary.plist"]];
    
    NSArray  * dataArray = [peiZhiDict objectForKey:@"result"];
    for (NSDictionary *dict in dataArray) {
        if ([dict[@"alias"] isEqualToString:key]) {
            arr = dict[@"child"];
            return arr;
        }
    }
    return arr;
}

+(NSString *)getDictValueWithSectionKey:(NSString *)key andKey:(NSString *)key1{
    NSArray *section = [XDCommonTool getSettingInfoWithKey:key];
    if (section.count>0) {
//        NSArray *section1 = [section getRelateInfoArrayWithArray:@[key1]];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *str in @[key1]) {
            for (NSDictionary *dict in section) {
                if ([dict[@"alias"] isEqualToString:str] ) {
                    XYSettingInfoModel *model = [XYSettingInfoModel yy_modelWithDictionary:dict];
                    [arr addObject:model];
                    break;
                }
            }
        }
        NSArray *section1 = [NSArray arrayWithArray:arr];
        
        if (section1.count>0) {
            XYSettingInfoModel *model = section1.firstObject;
            return model.name_zh;
        }else{
            return @"";
        }
    }
    return @"";
}

# pragma mark -
# pragma mark 常用控件的封装

//普通btn
+ (UIButton *)newButtonWithType:(UIButtonType)type normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action{
    // TODO: implement
    UIButton * btn = [UIButton buttonWithType:type];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
//带Frame的button
+ (UIButton *)newButtonWithType:(UIButtonType)type  frame:(CGRect)frame normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:type];
    [btn setFrame:frame];

    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}
//颜色转image
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//纯色btn
+ (UIButton *)newButtonWithType:(UIButtonType)type target:(id)target action:(SEL)action{
    // TODO: implement
    UIButton * btn = [UIButton buttonWithType:type];
    [btn setBackgroundImage:[XDCommonTool createImageWithColor:[UIColor colorWithRed:0 green:255 blue:0 alpha:1]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[XDCommonTool createImageWithColor:[UIColor colorWithRed:0 green:255 blue:255 alpha:1]] forState:UIControlStateHighlighted];
    [btn.layer setCornerRadius:10];
    [btn.layer setMasksToBounds:YES];
    
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//uiimageview
+(UIImageView *)newImageViewWithName:(NSString *)imageName
{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    return imageView;
}

//uitextfield
+ (UITextField *)newTextFieldWithStyle:(UITextBorderStyle)style   withPlaceHolder:(NSString *)placeHolderStr withKeyBoardType:(UIKeyboardType)type withFont:(UIFont*)font {
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectZero];
    [tf setBorderStyle:style];
    tf.placeholder = placeHolderStr;
    [tf setKeyboardType:type];
    tf.font = font;
 
    return tf;
}

//动态label
+(UILabel *)newDyLabelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    UILabel * label = [UILabel new];
    label.text = text;
    label.font = font;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName : label.font,
                                 NSParagraphStyleAttributeName: paragraph};
    
    CGRect box = [label.text
                  boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                  attributes:attributes context:nil];
    
    label.frame = box;
    return label;
}

+(UILabel *)newlabelWithTextColor:(UIColor*)color withTitle:(NSString*)title fontSize:(CGFloat)theSize
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setTextColor:color];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:theSize]];
    label.text = title;
    return label;
}
//拉伸图片
+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

+ (UISlider *)newSlider
{
    UISlider * slider = [UISlider new];
    [slider setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    return slider;
}

# pragma mark -
# pragma mark 第三方账号相关
//第三方账号相关
//注册
+ (void)thirdRegisterWithUserID:(NSString*)USERid withNickName:(NSString*)name withImage:(NSString*)imageUrlStr  withUserNameType:(NSNumber*)type{
    NSDictionary  * DICT = @{@"open_id":USERid,@"type":type,@"icon":imageUrlStr,@"nick_name":name};
    [[NetworkClient sharedClient] POST:URL_THIRDREGISTER dict:DICT succeed:^(id data) {
            [self thirdLoginWithUserID:USERid withUserNameType:@2];
     
    } failure:^(NSError *error) {
        
    }];
}
//第三方登录
+ (void)thirdLoginWithUserID:(NSString*)USERid   withUserNameType:(NSNumber*)type{
    NSDictionary*dict = @{@"identify":USERid,@"type":type};
    
    [[NetworkClient sharedClient] POST:URL_LOGIN dict:dict succeed:^(id data) {
        LRLog(@"QQ登录%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"登录成功"];
            NSDictionary  * userDict = [data objectForKey:@"result"];
            [XDCommonTool saveToUserDefaultWithBool:YES key:IS_LOGIN];
            //第三方登录
            [XDCommonTool saveToUserDefaultWithBool:YES key:IS_THIRD_LOGIN];
            //个人信息存本地
            [XDCommonTool saveToUserDefaultWithDic:userDict  key:USER_INFO];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:THIRD_LOGIN_SUC object:self];
        
        }

    
    
    } failure:^(NSError *error) {
        LRLog(@"登录%@",error);
        
    }];
}
/**
 *  发送验证码
 *
 *  @param phoneStr      手机或者邮箱
 *  @param type          类型 1：注册 0：非注册
 *  @return
 */
+(void)SendMessageWithPhoneOrMail:(NSString*)phoneStr  withType:(NSNumber*)type{
    
    [SVProgressHUD showWithStatus:@"正在获取验证码"];
    
    //获取毫秒时间戳：
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]/60;
    
    NSString  * str = [NSString stringWithFormat:@"%llublinroom%@",recordTime,phoneStr];
    NSDictionary  * dict = [NSDictionary new];
    
    NSString  * urlStr = [NSString new];
    
    if ([self checkTel:phoneStr]) {
        dict = @{@"dynamic_cipher":[XDCommonTool md5:str],@"phone":phoneStr,@"status":type};
        urlStr = URL_SENDERCODE;
    }
    else{
        
        dict = @{@"dynamic_cipher":[XDCommonTool md5:str],@"email":phoneStr,@"status":type};
        urlStr =URL_SENDERMAILCODE;
    }
    [[NetworkClient sharedClient] POST:urlStr dict:dict succeed:^(id data) {
        [SVProgressHUD dismiss];

        LRLog(@"%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"验证码发送成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:CODESUCCESS object:self ];
            
        }else{
            
            
            if ([data [@"error_code"]  isEqualToNumber:[NSNumber numberWithInt:40007]]) {
                [XDCommonTool alertWithMessage:@"操作频繁，请稍后再试"];
 
            }
            
            if ([data [@"error_code"]  isEqualToNumber:[NSNumber numberWithInt:40102]]) {
                [XDCommonTool alertWithMessage:@"该用户已被注册"];

            }
            
            // [XDCommonTool alertWithMessage:[data objectForKey:@"error_msg"]];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];

    }];
    
    
}

//微信第三方登录拿昵称

+(void) requestWeChatInfo:(void (^)(NSDictionary* tJsonDic))success
                     fail:(void (^)(NSDictionary* tJsonDic))failure
                     code:(NSString*)code
{
    NSString* tURL =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",URL_WECHAT_APPID,URL_WECHAT_APPSECRET,code];
    
    //@" https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code"
    
    NSString* encodedString = [tURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NetworkClient * manager = [NetworkClient sharedClient];
    
    [manager GET:encodedString dict:nil succeed:^(id data) {
        //NSString * responseString =[[NSString alloc] initWithData:data
        // encoding:NSUTF8StringEncoding];
        
        // NSDictionary * responseDic = [responseString JSONValue];
        
        NSDictionary  * responseDic = (NSDictionary*)data;
        if([responseDic isKindOfClass:[NSDictionary class]])
        {
            NSString* tAccessToken =[responseDic objectForKey:@"access_token"];
            NSString* tOpenId =[responseDic objectForKey:@"openid"];
            if ([tAccessToken length] > 0&& [tOpenId length] > 0) {
                //请求详细信息
                [self requestWeChatUserInfo:^(NSDictionary *tJsonDic) {
                    success(tJsonDic);
                    
                } fail:^(NSDictionary *tJsonDic) {
                    failure(tJsonDic);
                } accesstoken:tAccessToken openid:tOpenId];
            }else{
                failure(nil);
            }
        }else{
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        LRLog(@"Error: %@", error);
        
    }];
    
    
    
    
}


/**
 * 微信拿昵称(接上面) -----私有
 * @Param
 * @Return
 */
+(void) requestWeChatUserInfo:(void (^)(NSDictionary* tJsonDic))success
                         fail:(void (^)(NSDictionary* tJsonDic))failure
                  accesstoken:(NSString*)accesstoken
                       openid:(NSString*)openid
{
    NSString* tURL =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accesstoken,openid];
    NSString* encodedString = [tURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NetworkClient * manager = [NetworkClient sharedClient];
    
    
    
    [manager GET:encodedString dict:nil succeed:^(id data) {
        //        NSString * responseString =[[NSString alloc] initWithData:data
        //                                                                                             encoding:NSUTF8StringEncoding];
        //
        //                                            NSDictionary * responseDic = [responseString JSONValue];
        
        NSDictionary  * responseDic = (NSDictionary*)data;
        
        if ([responseDic isKindOfClass:[NSDictionary class]] && responseDic!= nil) {
            success(responseDic);
        }else{
            failure(nil);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}
+(void)boundWithID:(NSString*)clientIdStr  openId:(NSString*)openIdSt nickName:(NSString*)nickNameStr type:(NSString*)typeStr{

    NSDictionary  * boundDict = [NSDictionary new];
    if ([typeStr isEqualToString:@"1"]) {
        boundDict=@{@"client_id":clientIdStr,@"qq_open_id":openIdSt,@"qq_nick_name":nickNameStr};

    }if ([typeStr isEqualToString:@"2"]) {
        boundDict=@{@"client_id":clientIdStr,@"we_chat_id":openIdSt,@"we_chat_nick_name":nickNameStr};
        
    }
     [[NetworkClient sharedClient] POST:URL_BOUND dict:boundDict succeed:^(id data) {
        LRLog(@"%@",data);
        
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"绑定成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BOUND_SUC object:self];

        
        }
        else{
            [XDCommonTool alertWithMessage:[data objectForKey:@"error_msg"]];

        }
      
        
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
}
+ (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array
{
    if (![array count] || ![fieldArray count])
    {
        return nil;
    }
    
    NSPredicate *scopePredicate;
    NSMutableArray *backArray = [NSMutableArray array];
    
    for (NSString *fieldString in fieldArray)
    {
        NSArray *tempArray = [NSArray array];
        scopePredicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@", fieldString, inputString];
        tempArray = [array filteredArrayUsingPredicate:scopePredicate];
        for (NSObject *object in tempArray)
        {
            if (![backArray containsObject:object])
            {
                [backArray nd_addObj:object];
            }
        }
    }
    
    return backArray;
}


@end
