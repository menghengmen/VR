//
//  ImageCell.m
//  WalkTogether2
//
//  Created by gw on 16/3/30.
//  Copyright © 2016年 GYJ. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation ImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}
- (IBAction)btnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageCell:withIndexPath:)]) {
        [self.delegate imageCell:self withIndexPath:self.indexPath];
    }
}

@end
