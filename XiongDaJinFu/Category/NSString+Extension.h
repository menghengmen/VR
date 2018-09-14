//
//  NSString+Extension.h
//  Essential-New
//
//  Created by Alex on 16/3/12.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ESDateFormatType) {
    ESDateFormatTypeSlash,///< 中间是斜杠
    ESDateFormatTypeDash///< 中间是横杠
};

@interface NSString (Extension)
/**
 *  字典转字符串
 */
+ (NSString *)stringWithDictionary:(NSDictionary *)dic;

- (BOOL)isPhoneNumber;

- (NSString *)formattedDateDescriptionWith:(ESDateFormatType)type;

/**
 *  时间戳转日期和时间
 *
 *  @return 日期和时间
 */
- (NSString *)formattedDateAndTime;
/**
 *  返回字符数
 */
- (NSUInteger)unicodeLengthOfString;


/**
 *  去除多余的零
 */
- (NSString *)removeZeroInBack:(CGFloat)moneyStr;

//生成随机数
+ (NSString *)createRandomString:(NSInteger)length;

@end
