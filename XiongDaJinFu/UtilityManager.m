//
//  UtilityManager.m
//  VideoPlay
//
//  Created by WangLi on 15/4/2.
//  Copyright (c) 2015年 WangLi. All rights reserved.
//

#import "UtilityManager.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "MBProManager.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
//#import "PinYin4Objc.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

static UtilityManager *    s_UtilManager = nil;
@implementation UtilityManager
{
    NSArray             *_HeartImgArr;
    NSMutableArray      *_MutArr;
    NSMutableArray      *_MutCitysArr;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_UtilManager = [[UtilityManager alloc] init];
    });
    return s_UtilManager;
}


/**
 * 对象转JSON STRING
 * @Param
 * @Return
 */
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        LRLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        LRLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark-
#pragma mark 流量监控


/**
 * 获得蜂窝数据下流量变化
 * @Param
 * @Return
 */
+(long long int) getGprs3GFlowIOBytes:(int)type
{
    
    struct ifaddrs *ifa_list= 0, *ifa;
    
    if (getifaddrs(&ifa_list)== -1) {
        
        return 0;
        
    }
    
    uint32_t iBytes =0;
    
    uint32_t oBytes =0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
        
    {
        
        if (AF_LINK!= ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags& IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data== 0)
            
            continue;
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0")) {
            
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            LRLog(@"%s :iBytes is %d, oBytes is %d",ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    if (type == 0) {
        return oBytes;
    }else{
        return iBytes;
    }
}

/**
 * 2.WIFI流量统计功能 返回的结果为byte
 * @Param
 * @Return
 */
+ (long long int)getInterfaceBytes:(int )retype
{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1) {
        
        return 0;
        
    }
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2))
            
        {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            //            DDLogInfo(@"%s :iBytes is %d, oBytes is %d",
            
            //                  ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    if (retype == 0) {
        return oBytes;
    }else{
        return iBytes;
    }
    
}

+(void) countLocalFiles
{
// AvatarImageFolder
// FirstImageFolder
// HotImageFolder
    
}


/**
 * 计算缓存大小
 * @Param
 * @Return
 */
+(float) caculateCacheSize:(NSArray*)folders
{
    unsigned long  filesSize = 0;
    for (NSString* folder in folders) {
        NSFileManager* tFileManager = [NSFileManager defaultManager];
        NSString* tTemp = NSTemporaryDirectory();
        NSString *pblName=[tTemp stringByAppendingPathComponent:folder];
        if ([tFileManager fileExistsAtPath:pblName]) {
            NSError* error = nil;
            NSArray* inFilesArr =[tFileManager contentsOfDirectoryAtPath:pblName error:&error];
            if (error  == nil) {
                for (NSString* tFileName in inFilesArr) {
                    NSString * filecheck=[pblName stringByAppendingPathComponent:tFileName];
                    if ([tFileManager fileExistsAtPath:filecheck]) {
                        NSDictionary *fileAttributes = [tFileManager attributesOfItemAtPath:filecheck error:nil];
                        unsigned long long tmplength = [fileAttributes fileSize];
                        filesSize+=tmplength;
                    }else{
                        LRLog(@"文件不存在 =%@",filecheck);
                    }
                }
            }else{
                LRLog(@"folder =%@ err=%@",folder,[error description]);
            }
        }
    }
    
    float  filseSizeMB = (filesSize) / 1024.0 /1024.0;
    return filseSizeMB;
}

/**
 * 清除缓存大小
 * @Param
 * @Return
 */
+(BOOL)cleanCache:(NSArray*)folders
{
    for (NSString* folder in folders) {
        NSFileManager* tFileManager = [NSFileManager defaultManager];
        NSString* tTemp = NSTemporaryDirectory();
        NSString *pblName=[tTemp stringByAppendingPathComponent:folder];
        if ([tFileManager fileExistsAtPath:pblName]) {
            NSError* error = nil;
            NSArray* inFilesArr =[tFileManager contentsOfDirectoryAtPath:pblName error:&error];
            if (error  == nil) {
                for (NSString* tFileName in inFilesArr) {
                    NSString * filecheck=[pblName stringByAppendingPathComponent:tFileName];
                    if ([tFileManager fileExistsAtPath:filecheck]) {
                        if (![tFileManager removeItemAtPath:filecheck error:&error]){
                            LRLog(@"文件删除失败 %@  err= %@",filecheck,[error description]);
                            return NO;
                        }
                    }else{
                        LRLog(@"文件不存在 =%@",filecheck);
                        return NO;
                    }
                }
            }else{
                LRLog(@"folder =%@ err=%@",folder,[error description]);
                return NO;
            }
        }
    }
    return YES;
}


/**
 * 以上获取的数据可以通过以下方式进行单位转换
 * @Param
 * @Return
 */
+ (NSString*) bytesToAvaiUnit:(int )bytes
{
    
    if(bytes < 1024)  // B
    {
        
        return [NSString stringWithFormat:@"%dB", bytes];
        
    }
    else if(bytes >= 1024 && bytes < 1024 * 1024) // KB
    {
        
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
        
    }
    
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) // MB
    {
        
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
        
    }
    
    else // GB
    {
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
        
    }
    
}
+(NSString *)int2String:(int)num
{

    if(num<10)
    {
        return    [NSString stringWithFormat:@"0%d",num];

    }else
    {
        return    [NSString stringWithFormat:@"%d",num];

    }
}

/**
 * 秒数转 分''秒'
 * @Param
 * @Return
 */
+(NSString*) secondToStr:(long long)sec
{
    int tHourNum = (int)sec/3600;
    int tFenNum = (int)(sec%3600/60);
    int tSecNum = sec%60;

    if(tHourNum <= 0)
    {
        return [NSString stringWithFormat:@"%@:%@",[UtilityManager int2String:tFenNum],[UtilityManager int2String:tSecNum]];
    }else
    {
        return [NSString stringWithFormat:@"%@:%@:%@",[UtilityManager int2String:tHourNum],[UtilityManager int2String:tFenNum],[UtilityManager int2String:tSecNum]];
    }
}


/**
 * 截取部分图像
 * @Param
 * @Return
 */
+(UIImage*)getSubImage:(CGRect)rect srcImg:(UIImage*)srcimg
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(srcimg.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    
    return smallImage;
}

/**
 * 爸爸的剪裁方式
 * @Param
 * @Return
 */
+ (UIImage *) drawSmallToSize:(UIImage *)img size:(CGRect)drawrect
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(drawrect.size, YES, [UIScreen mainScreen].scale);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(drawrect.origin.x, drawrect.origin.y, img.size.width, img.size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return smallImage;
}

/**
 * 放缩图片
 * @Param
 * @Return
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage; 
}

/**
 * 强制翻转成竖屏
 * @Param
 * @Return
 */
+(void) forceRotateToPortrait
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


/**
 * tableView 底部的加载更多
 * @Param
 * @Return
 */
+(UIView*) tableViewMore
{
    UIView* tMoreFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    [tMoreFootView setBackgroundColor:[UIColor clearColor]];
    UIActivityIndicatorView* tActView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-80, 11, 22, 22)];
    [tMoreFootView addSubview:tActView];
    [tActView startAnimating];
    UILabel* tMoreLab = [[UILabel alloc] initWithFrame:tMoreFootView.bounds];
    [tMoreLab setBackgroundColor:[UIColor clearColor]];
    [tMoreLab setText:@"正在加载数据"];
    tMoreLab.textAlignment = NSTextAlignmentCenter;
    tMoreLab.font = [UIFont systemFontOfSize:14];
    [tMoreLab setTextColor:RGB(121, 120, 153)];
    [tMoreFootView addSubview:tMoreLab];
    return tMoreFootView;
}


/**
 * tableView 底部的加载更多
 * @Param
 * @Return
 */
+(UIView*) tableViewMore:(int)width
{
    UIView* tMoreFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    [tMoreFootView setBackgroundColor:[UIColor clearColor]];
    UIActivityIndicatorView* tActView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-80, 11, 22, 22)];
    [tMoreFootView addSubview:tActView];
    [tActView startAnimating];
    UILabel* tMoreLab = [[UILabel alloc] initWithFrame:tMoreFootView.bounds];
    [tMoreLab setBackgroundColor:[UIColor clearColor]];
    [tMoreLab setText:@"正在加载数据"];
    tMoreLab.textAlignment = NSTextAlignmentCenter;
    tMoreLab.font = [UIFont systemFontOfSize:14];
    [tMoreLab setTextColor:RGB(121, 120, 153)];
    [tMoreFootView addSubview:tMoreLab];
    return tMoreFootView;
}

/**
 * 心得动画生成一个
 * @Param
 * @Return
 */
-(UIView*) doHeartImgAnimate:(CGPoint)start
{
    if (_HeartImgArr == nil) {
        _HeartImgArr = @[[UIImage imageNamed:@"heart_1.png"],[UIImage imageNamed:@"heart_2.png"],[UIImage imageNamed:@"heart_3.png"],[UIImage imageNamed:@"heart_4.png"]];
    }
    if (_MutArr == nil) {
        _MutArr = [NSMutableArray array];
    }
    static int tHeartIndex = 0;
    UIImageView* tHeartView = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, 26, 26)];
    [tHeartView setImage:_HeartImgArr[tHeartIndex%4]];
    tHeartView.tag =tHeartIndex;
    [_MutArr addObject:tHeartView];
    tHeartIndex++;
    return tHeartView;
}
-(CAAnimationGroup*) customInitAnimate:(CGPoint)start
{
    CAAnimationGroup* tAniGroup = [CAAnimationGroup animation];
    static int tAnimateIndex = 0;
    CAKeyframeAnimation* tKeyframe0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath* tBezier = [UIBezierPath bezierPath];
    [tBezier moveToPoint:CGPointMake(start.x, start.y)];
    int x = arc4random() % 30;
    int xx = arc4random() % 100;
    LRLog(@"xx = %d",xx);
    if (tAnimateIndex%2==0) {
        [tBezier addCurveToPoint:CGPointMake(start.x-10-xx, start.y-300-xx) controlPoint1:CGPointMake(start.x+50+xx, start.y-40-x) controlPoint2:CGPointMake(start.x-50-xx, start.y-70-x)];
    }else{
        [tBezier addCurveToPoint:CGPointMake(start.x-10-xx, start.y-300-xx) controlPoint1:CGPointMake(start.x-50-xx, start.y-40-x) controlPoint2:CGPointMake(start.x+50+xx, start.y-70-x)];
    }
    [tKeyframe0 setPath:tBezier.CGPath];
    tKeyframe0.removedOnCompletion = NO;
    tKeyframe0.autoreverses = NO;
    tKeyframe0.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tKeyframe0.repeatCount= 1;
    tKeyframe0.fillMode =kCAFillModeForwards;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.8, 1.8, 1.0)];
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.autoreverses =NO;
    scaleAnim.repeatCount =1;
    scaleAnim.fillMode =kCAFillModeForwards;
    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.2];
    opacityAnim.removedOnCompletion = NO;
    opacityAnim.autoreverses =NO;
    opacityAnim.repeatCount = 1;
    opacityAnim.fillMode =kCAFillModeForwards;
    
    
    tAniGroup.animations =@[tKeyframe0,scaleAnim,opacityAnim];
    tAniGroup.duration = 3.f;
    tAniGroup.delegate = self;
    tAniGroup.repeatCount =1;
    tAniGroup.autoreverses =NO;
    tAniGroup.removedOnCompletion = NO;
    tAniGroup.fillMode =kCAFillModeForwards;
    tAnimateIndex++;
    return tAniGroup;
}

-(void) cleanAllAnimate
{
    for (UIImageView* tHeartView in _MutArr) {
//        CAAnimationGroup* tAniGroup =(CAAnimationGroup*)[tHeartView.layer animationForKey:@"heartGroup"];
        [tHeartView.layer removeAllAnimations];
        [tHeartView removeFromSuperview];
        [tHeartView setImage:nil];
    }
    [_MutArr removeAllObjects];
}

#pragma mark-
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if (flag) {
    if ([_MutArr count] > 0) {
        UIImageView* tHeartView = (UIImageView*)[_MutArr objectAtIndex:0];
        [tHeartView removeFromSuperview];
        [_MutArr removeObject:tHeartView];
        [tHeartView setImage:nil];
        tHeartView = nil;
    }
//    }
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

/**
 * 字串MD5 加密
 * @Param
 * @Return
 */
- (NSString *)md5:(NSString *)str
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
 * 判断是否是手机号
 * @Param
 * @Return
 */
-(BOOL) checkPhoneNum:(NSString*)phoneStr
{
    if ([phoneStr length] != 11) {
        return NO;
    }
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate * phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![phonePre evaluateWithObject:phoneStr];
}




/**
 * 根据城市ID 查名字
 * @Param
 * @Return
 */
-(NSString*) cityIDQueryName:(int) cityID
{
    NSPredicate * tPred = [NSPredicate predicateWithFormat:@"id == %d",cityID];
    for(NSDictionary* tDic in [self GetLocalCitysArr]){
        if ([tPred evaluateWithObject:tDic]) {
            return [tDic objectForKey:@"name"];
        }
    }
    return @"";
}

/**
 * 转码unicode 除数字和字母
 * @Param
 * @Return
 */
-(NSString*) escapedStringAll:(NSString*)unescaped
{
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef) unescaped,
                                                                                                    NULL,
                                                                                                    CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                                    kCFStringEncodingUTF8));
    return escapedString;
}
+ (BOOL)isHttpURL:(NSString *)urlString {
    NSRange rangehttp,rangehttps;
    rangehttp.length = 0;
    rangehttps.length = 0;
    NSString * httpString = [urlString lowercaseString];

    rangehttp = [httpString rangeOfString:@"http://"];
    rangehttps = [httpString rangeOfString:@"https://"];
    if ((rangehttp.length != 0 && rangehttp.location == 0)
        ||(rangehttps.length != 0 && rangehttps.location == 0)) {
        return true;
    }else
    {
        return false;
    }
}

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
#pragma mark-
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}
+(NSString *)giftDirectoryWithContentNameByCreation:(NSString *)fileName
{
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSString * giftDirectory =[documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:giftDirectory]) {
        [fileManager createDirectoryAtPath:giftDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    return giftDirectory;
    
}
+(NSString *)giftDirectoryWithContentName:(NSString *)fileName
{
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSString * giftDirectory =[documentsDirectory stringByAppendingPathComponent:fileName];
    
    return giftDirectory;
    
}

/**
 * 检查某功能是否允许访问
 * @Param
 * @Return
 */
-(BOOL) checkIsAuthor:(NSString*)checkType
{
    NSString *mediaType = checkType;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        LRLog(@"相机权限受限");
        UIAlertView*  tAlert = nil;
        NSString*   tTitleStr = nil;
        NSString*   tTipStr = nil;
        if ([checkType isEqualToString:AVMediaTypeVideo]) {
            tTitleStr =@"相机权限未开启";
            tTipStr=@"未授权本APP相机权限！";
        }else if([checkType isEqualToString:AVMediaTypeAudio]){
            tTitleStr =@"麦克风权限未开启";
            tTipStr=@"未授权本APP麦克风权限！";
        }
        if (SYSTEM_VERSION >= 8.0) {
            tAlert = [[UIAlertView alloc] initWithTitle:tTitleStr message:[NSString stringWithFormat:@"%@是否去开启？",tTipStr] delegate:self cancelButtonTitle:@"算了" otherButtonTitles:@"去设置", nil];
        }else{
            tAlert = [[UIAlertView alloc] initWithTitle:tTitleStr message:[NSString stringWithFormat:@"%@请用户手动去设置内更改",tTipStr] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        }
        [tAlert show];
        return NO;
    }
    return YES;
}


/**
 * 中文转拼音
 * @Param
 * @Return
 */
//+ (NSString *) phonetic:(NSString*)sourceString
//{
//    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:sourceString withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
//    outputFormat =nil;
//    return outputPinyin;
//}


@end
