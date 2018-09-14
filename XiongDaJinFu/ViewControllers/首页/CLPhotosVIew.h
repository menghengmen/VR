//
//  CLPhotosVIew.h
//  高仿发微博
//
//  Created by darren on 16/6/24.
//  Copyright © 2016年 shanku. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^visitCameraBlock)();
typedef void(^removeImageBlock)(NSInteger index);


@interface CLPhotosVIew : UIView
/**存放图片的数组*/
@property (nonatomic,strong) NSArray *photoArray;


/**调用相机*/
@property (nonatomic,copy) visitCameraBlock clickChooseView;
@property (nonatomic,copy) removeImageBlock clickcloseImage;

@end
