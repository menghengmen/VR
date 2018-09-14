//
//  NSNumber+Extension.m
//  Essential-New
//
//  Created by Alex on 16/3/8.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "NSNumber+Extension.h"

@implementation NSNumber (Extension)

+ (NSNumber *)numberWithHexString:(NSString *)string {
    NSString *str = [string  lowercaseString];
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}


@end
