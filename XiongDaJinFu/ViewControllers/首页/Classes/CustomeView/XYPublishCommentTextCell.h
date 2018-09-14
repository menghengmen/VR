//
//  XYPublishCommentTextCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPublishCommentTextCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHoldLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic,copy) void(^textDidChangedBlock)(UITextView *textView);
@end
