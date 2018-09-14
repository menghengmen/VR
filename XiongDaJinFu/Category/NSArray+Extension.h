//
//  NSArray+Extension.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
/**
 在数组中根据键获取对应对象
 
 @param key key
 @return 对应对象
 */
-(NSArray *)getRelateInfoArrayWithArray:(NSArray *)array;

-(NSArray *)getRelateInfoArrayWithArray:(NSArray *)array oldArray:(NSArray *)oldArray;
@end
