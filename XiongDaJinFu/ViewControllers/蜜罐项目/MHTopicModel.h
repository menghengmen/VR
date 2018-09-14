//
//  MHTopicModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/21.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHUserModel.h"
#import "MHContentModel.h"







@interface MHTopicModel : NSObject



@property (nonatomic,strong) MHContentModel *content;
@property (nonatomic,strong) NSNumber *comment_count;

@property(nonatomic,copy)  NSNumber  * create_at;

@property(nonatomic,copy)  NSString  * feed_id;
@property (nonatomic,strong) NSNumber *feed_type;

@property (nonatomic,assign) BOOL following;
@property (nonatomic,assign) BOOL is_liked;
@property (nonatomic,strong) NSNumber *likes_count;
@property (nonatomic,copy)   NSString *share_url;
@property (nonatomic,strong) NSNumber *shared_count;

@property (nonatomic,strong) NSNumber *updated_at;

@property (nonatomic,strong) MHUserModel *user;



@end


