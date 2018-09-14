//
//  YJTopicCell.m
//  WalkTogether2
//
//  Created by boding on 15/7/29.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import "YJTopicCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+DateTools.h"
#import "MHTopicModel.h"

#define globalImgURl @"http://www.com179.com/file"

#define kImgTag 1100
#define globalImageUrl @"http://f1.kkmh.com/"
@interface YJTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *lblnteres;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIImageView *funImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thereImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblDstance;
@property (weak, nonatomic) IBOutlet UIImageView *prasieImageView;

@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblPrasieCount;

@property (strong, nonatomic) IBOutlet UILabel *pingLunLabel;


@end

@implementation YJTopicCell


- (NSArray *)imageViewArr
{
    if (!_imageViewArr) {
        _imageViewArr = @[self.firstImageView,self.secondImageView,self.thereImageView];
    }
    return _imageViewArr;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Fix the bug in iOS7 - initial constraints warning
    self.contentView.bounds = [UIScreen mainScreen].bounds;    
    self.headerIcon.layer.cornerRadius = 20;

}

- (void)setUserModel:(MHUserModel *)userModel{

    _userModel = userModel;
    self.userName.text = userModel.nickname;
    
    
    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] placeholderImage:nil];


}



- (void)setContentTopic:(MHContentModel*)contentModel{

    _contentTopic = contentModel;
    self.lblContent.text = contentModel.text;

   //图片
    for (int i = 0; i <3 &&i <contentModel.images.count; i ++) {
        NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@",globalImageUrl,contentModel.images[i]];
                [self.imageViewArr[i] sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
    }

}



- (void)setTopic:(MHTopicModel *)topic
{

    _topic = topic;
//    if ([self.topic.ispraised integerValue]>0) {
//        [self.prasieImageView setImage:[UIImage imageNamed:@"topicPraise_selected"]];
//    }
//    
   // [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",globalImgURl,topic.creatorhead]]];
   // self.userName.text = topic.user.nickname ;
   // self.lblContent.text = topic.content.text;
    
    //赞
    self.lblPrasieCount.text = [NSString stringWithFormat:@"%@",topic.likes_count];
  // 评论
    self.pingLunLabel.text = [NSString stringWithFormat:@"%@",topic.comment_count];
    self.pingLunLabel.backgroundColor = [UIColor redColor];
    
    //发布时间
  
    XDCommonTool  * coo = [XDCommonTool new];
    
    self.lblTime.text = [NSDate timeAgoSinceDate:[NSDate dateWithString:[NSString stringWithFormat:@"%@",topic.create_at] formatString:@"yyyy-MM-dd HH:mm:ss"]];
//    if (topic.imageArr.count == 0)
//    {
//        self.imgPanelView.hidden = YES;
//    }
//    else
//    {
//        self.imgPanelView.hidden = NO;
//        for (int i = 0; i < 3 && i < topic.imageArr.count ; i++)
//        {
//            NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@",globalImgURl,topic.imageArr[i]];
//            [self.imageViewArr[i] sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
//        }
//
//    }
}

- (IBAction)btnAction:(UIButton *)sender {

    NSUInteger index = sender.tag;
    BOOL isPrasie = NO;
    if (self.contentTopic.images.count < index - 2 && index > 2) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(topicCell:didSelectLable:isPraise:indexPath:)] && self.delegate)
    {
        [self.delegate topicCell:self didSelectLable:index isPraise:isPrasie indexPath:self.indexPath];
    }

    
}




@end
