//
//  SAReachabilityManager.m
//  SAFramework
//
//  Created by whs on 15/3/7.
//  Copyright (c) 2015年 whs. All rights reserved.
//

#import "SAReachabilityManager.h"

@implementation SAReachabilityManager

@synthesize internetReach;

static SAReachabilityManager *_reachabilityManager = nil;

- (void)reachabilityChanged:(NSNotification*)note {
	
	Reachability* curReach = [note object];
	//	NSParameterAssert([curReach isKindOfClass:[Reachability class]]); // TReachability? wtf? since YummyDiary v1.1.0 13-04-27
	NSParameterAssert([curReach respondsToSelector:@selector(currentReachabilityStatus)]);

}

+ (id)alloc {
	@synchronized([SAReachabilityManager class]) {
		NSAssert(_reachabilityManager == nil, @"Attempted to allocate a second instance of a singleton.");
		_reachabilityManager = [super alloc];
		return _reachabilityManager;
	}
	return nil;
}

- (id)init {
	self = [super init];
	if (self) {
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
		
		self.internetReach = [Reachability reachabilityForInternetConnection];
		[internetReach startNotifier];
	}
	return self;
}

+ (SAReachabilityManager *)sharedReachabilityManager {
	@synchronized([SAReachabilityManager class]) {
		if (!_reachabilityManager) {
			[[self alloc] init];
		}
		return _reachabilityManager;
	}
	return nil;
}

- (NetworkStatus)currentReachabilityStatus {
	return internetReach.currentReachabilityStatus;
}


@end
