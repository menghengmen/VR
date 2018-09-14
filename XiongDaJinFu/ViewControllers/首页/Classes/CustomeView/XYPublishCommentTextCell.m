//
//  XYPublishCommentTextCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYPublishCommentTextCell.h"

@implementation XYPublishCommentTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeHoldLabel.hidden = true;
    }
    return true;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeHoldLabel.hidden = false;
    }else{
        self.placeHoldLabel.hidden = true;
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >200){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:200];
        [textView setText:s];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
    
    if (self.textDidChangedBlock) {
        self.textDidChangedBlock (textView);
    }
    
    
}


//- (void)textViewDidChange:(UITextView *)textView
//{
//    CGRect bounds = textView.bounds;
//    // 计算 text view 的高度
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//    bounds.size = newSize;
//    textView.bounds = bounds;
//    // 让 table view 重新计算高度
//    UITableView *tableView = [self tableView];
//    [tableView beginUpdates];
//    [tableView endUpdates];
//    
//    if (self.textDidChangedBlock) {
//        self.textDidChangedBlock (textView);
//    }
//    
//    self.countLabel.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
//}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if (textView.text.length <= 200) {
//        return true;
//    }else{
//        return false;
//    }
//}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}

@end
