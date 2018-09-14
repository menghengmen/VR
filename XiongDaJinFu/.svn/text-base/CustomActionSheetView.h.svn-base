//
//  CustomActionSheetView.h
//  VideoPlay
//
//  Created by gary on 16/12/2.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CActionSheetDelegate <NSObject>

-(void) didSelectIndex:(int) index;
@end

@interface CustomActionSheetView : UIView
@property (nonatomic,weak) id<CActionSheetDelegate> delegate;
-(void) initBottons:(NSArray*) wordArr;
-(void) showSelf:(UIView*) tSuperView;
@end
