//
//  XYImageModel.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYImageModel : NSObject
@property (nonatomic,strong) NSString *picId;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,assign) XYPhonesType isVideo;
@end
