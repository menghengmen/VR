//
//  ELCConsole.m
//  ELCImagePickerDemo
//
//  Created by Seamus on 14-7-11.
//  Copyright (c) 2014年 ELC Technologies. All rights reserved.
//

#import "ELCConsole.h"

static ELCConsole *_mainconsole;

@implementation ELCConsole
+ (ELCConsole *)mainConsole
{
    if (!_mainconsole) {
        _mainconsole = [[ELCConsole alloc] init];
    }
    return _mainconsole;
}

- (id)init
{
    self = [super init];
    if (self) {
        myIndex = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    myIndex = nil;
    _mainconsole = nil;
}

- (void)addIndex:(int)index
{
    if (![myIndex containsObject:@(index)]) {
        [myIndex addObject:@(index)];
    }
}

- (void)removeIndex:(int)index
{
    [myIndex removeObject:@(index)];
}

- (void)removeAllIndex
{
    [myIndex removeAllObjects];
}

- (int)currIndex
{
    [myIndex sortUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < [myIndex count]; i++) {
        int c = [[myIndex objectAtIndex:i] intValue];
        if (c != i) {
            return i;
        }
    }
    return (int)[myIndex count];
}

- (int)numOfSelectedElements {
    
    return (int)[myIndex count];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com