//
//  NSString+Extension.h
//  快看漫画
//
//  Created by 金亮齐 on 2016/12/13.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGFloat)getTextWidthWithFont:(UIFont *)font;
- (CGFloat)getTextWidthWithFont:(UIFont *)font WithMaxSize:(CGSize)maxSize;

+ (NSString *)makeTextWithCount:(NSInteger)count;

- (NSDictionary *)getUrlStringParameters;

- (NSString *)md5_32;

- (NSString *)md5_16;

- (BOOL)isMobile;

+ (NSString *)timeStampWithDate:(NSDate *)date;
+ (NSString *)timeWithTimeStamp:(NSUInteger)timeStamp;

@end
