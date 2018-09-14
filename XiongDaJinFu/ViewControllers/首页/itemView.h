//
//  itemView.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol itemViewDelegate <NSObject>

- (void)tagClick:(NSInteger)tag;

@end


@interface itemView : UIView

@property  (nonatomic,weak)id<itemViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame withItemArray:(NSArray*)itemArray withEnglishArr:(NSArray*)itemEngArr;
@end
