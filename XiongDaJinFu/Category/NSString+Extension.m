//
//  NSString+Extension.m
//  Essential-New
//
//  Created by Alex on 16/3/12.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)stringWithDictionary:(NSDictionary *)dic{
    
    if (!dic) {
        return nil;
    }
    
    NSError *error;
    //处理请求体
    NSData *jsonDataDict =[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *str =[[NSString alloc] initWithData:jsonDataDict encoding:NSUTF8StringEncoding];
    return str;
}

- (BOOL)isPhoneNumber {
    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*格式化日期描述*/
- (NSString *)formattedDateDescriptionWith:(ESDateFormatType)type {
    NSString *str = self;
    if (self.length > 10) {
        str = [self substringToIndex:10];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    NSString *format = type == ESDateFormatTypeSlash ? @"yyyy/MM/dd" : @"yyyy-MM-dd";
    [dateFormatter setDateFormat:format];
    NSString *theDay = [dateFormatter stringFromDate:date];//日期的年月日
    
    return theDay;
}

- (NSString *)formattedDateAndTime{
    NSString *str = [self substringToIndex:self.length - 4];
    if (self.length > 10) {
        str = [self substringToIndex:10];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setDateFormat:format];
    NSString *theDay = [dateFormatter stringFromDate:date];//日期的年月日
    
    return theDay;
}

- (NSUInteger)unicodeLengthOfString {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

-(NSString *)removeZeroInBack:(CGFloat)moneyStr{
    NSString *str = [NSString stringWithFormat:@"%f",moneyStr];
    long len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

+ (NSString *)createRandomString:(NSInteger)length {
    NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:15];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}

@end
