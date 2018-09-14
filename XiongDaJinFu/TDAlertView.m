
/**
 gitHub : https://github.com/568071718/AlertView.git
 */

#import "TDAlertView.h"

@interface TDAlertCollectionCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) TDAlertItem *data;

@end

@implementation TDAlertCollectionCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIView *selectedView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView = selectedView;
    } return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}
- (void)setData:(TDAlertItem *)data {
    _data = data;
    _titleLabel.text = data.title;
    _titleLabel.font = data.font;
    _titleLabel.textColor = data.titleColor;
    self.backgroundColor = data.backgroundColor;
}
@end


@interface TDAlertView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic ,strong ,readonly) UIControl *backgroundView;
@property (nonatomic ,strong ,readonly) UIView *contentView;
@property (nonatomic ,strong ,readonly) UILabel *titleLabel;
@property (nonatomic ,strong ,readonly) UILabel *messageLabel;
@property (nonatomic ,strong ,readonly) UICollectionView *collectionView;
- (void)hide;
@end

@implementation TDAlertView


- (void)setHorizontalMaxOptionCount:(NSInteger)horizontalMaxOptionCount {
    if (horizontalMaxOptionCount <1) _horizontalMaxOptionCount = 1;
    else _horizontalMaxOptionCount = horizontalMaxOptionCount;
}

- (void)setVerticalMaxOptionCount:(NSInteger)verticalMaxOptionCount {
    if (verticalMaxOptionCount <1) _verticalMaxOptionCount = 1;
    else _verticalMaxOptionCount = verticalMaxOptionCount;
}

+ (TDAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message items:(NSArray<TDAlertItem *> *)items delegate:(id<TDAlertViewDelegate>)delegate {
    TDAlertView *alert = [[TDAlertView alloc] initWithTitle:title message:message items:items delegate:delegate];
    return alert;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray<TDAlertItem *> *)items delegate:(id<TDAlertViewDelegate>)delegate {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.hideWhenclickItem = true;
        NSAssert((title.length > 0 || message.length >0), @"-- TDAlertView ( !title && !message ) --");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name: UIDeviceOrientationDidChangeNotification object:nil];
        
        _hideWhenTouchBackground = YES;
        _optionsRowHeight = 44.f;
        _horizontalMaxOptionCount = 2;
        _verticalMaxOptionCount = 4;
        _alertWidth = 288.f;
        _edgeInsets = UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f);
        
        _title = title;
        _message = message;
        _items = items;
        _delegate = delegate;
        
        _backgroundView = [[UIControl alloc] init];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        _backgroundView.alpha = 0;
        [_backgroundView addTarget:self action:@selector(backgroundClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 6;
        _contentView.layer.masksToBounds = YES;
        _contentView.alpha = 0;
        [self addSubview:_contentView];
        //标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [_contentView addSubview:_titleLabel];
        //描述
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        [_contentView addSubview:_messageLabel];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = .5;
        layout.minimumInteritemSpacing = .5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
      //中间的分割线
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        
       [_collectionView registerClass:[TDAlertCollectionCell class] forCellWithReuseIdentifier:@"alert_cell"];
        [_contentView addSubview:_collectionView];
        
        
        
//        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//        animation.duration = .25;
//        NSMutableArray *values = [NSMutableArray array];
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//        animation.values = values;
//        [_contentView.layer addAnimation:animation forKey:nil];
//        
//        [UIView animateWithDuration:.25 animations:^{
//            _backgroundView.alpha = 1;
//            _contentView.alpha = 1;
//        }];
    } return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .25;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:.25 animations:^{
        _backgroundView.alpha = 1;
        _contentView.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)backgroundClickAction:(id)sender {
    if (_hideWhenTouchBackground) {
        [self hide];
    }
}

#pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    TDAlertCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"alert_cell" forIndexPath:indexPath];
    cell.data = _items[indexPath.row];
       
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
   
    TDAlertCollectionCell *cell = (TDAlertCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.data.handle) {
        cell.data.handle();
    }
    //代理
    if ([self.delegate respondsToSelector:@selector(alertView:didClickItemWithIndex:)]) {
        [self.delegate alertView:self didClickItemWithIndex:indexPath.row];
    }
    
    if (self.hideWhenclickItem) {
        [self hide];
    }
        
    
    
}

#pragma mark - layout

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    _titleLabel.text = _title;
    if ([_message isKindOfClass:[NSAttributedString class]]) {
        _messageLabel.attributedText = _message;
    } else if ([_message isKindOfClass:[NSString class]]) {
        _messageLabel.text = _message;
    }
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    if (_items.count >_horizontalMaxOptionCount) {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    } else {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    if (_items.count >_horizontalMaxOptionCount) {
        return CGSizeMake(collectionView.frame.size.width, _optionsRowHeight);
    } else {
        return CGSizeMake((collectionView.frame.size.width - layout.minimumLineSpacing) / _items.count , _optionsRowHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section; {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return UIEdgeInsetsMake(layout.minimumLineSpacing, 0, 0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    
    // title
    {
        CGRect titleRect = [_title boundingRectWithSize:CGSizeMake(_alertWidth -_edgeInsets.left -_edgeInsets.right, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_titleLabel.font}
                                                context:nil];
        _titleLabel.bounds = CGRectMake(0, 0, titleRect.size.width, titleRect.size.height);
        _titleLabel.center = CGPointMake(_alertWidth *.5,
                                         titleRect.size.height *.5 +_edgeInsets.top);
    }
    
    
    // message
    {
        CGRect messageRect = CGRectZero;
        if ([_message isKindOfClass:[NSAttributedString class]]) {
            NSDictionary *attributes = [_messageLabel.attributedText attributesAtIndex:0 effectiveRange:nil];
            NSMutableDictionary *newAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
            UIFont *font;
            for (NSString *key in attributes.allKeys) {
                if ([key isEqualToString:NSFontAttributeName]) {
                    font = attributes[NSFontAttributeName];
                    break;
                }
            }
            if (!font) {
                [newAttributes setObject:_messageLabel.font forKey:NSFontAttributeName];
            }
            messageRect = [_messageLabel.attributedText.string boundingRectWithSize:CGSizeMake(_alertWidth -_edgeInsets.left -_edgeInsets.right, MAXFLOAT)
                                                                            options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:newAttributes
                                                                            context:nil];
        } else {
            messageRect = [_messageLabel.text boundingRectWithSize:CGSizeMake(_alertWidth -_edgeInsets.left -_edgeInsets.right, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:_messageLabel.font}
                                                           context:nil];
        }
        messageRect.size.width = messageRect.size.width < _alertWidth -_edgeInsets.left -_edgeInsets.right ? _alertWidth -_edgeInsets.left -_edgeInsets.right : messageRect.size.width;
        messageRect.origin.x = _edgeInsets.left;
        CGFloat maxY = CGRectGetMaxY(_titleLabel.frame);
        messageRect.origin.y = maxY <=0 ? _edgeInsets.top : messageRect.size.height >0 ? maxY + 8 : maxY;
        _messageLabel.frame = messageRect;
    }
    
    
    // options
    {
        CGFloat collectionHeight = 0;
        if (_items.count >0) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
            if (_items.count >_horizontalMaxOptionCount) {
                NSInteger count = _items.count > _verticalMaxOptionCount ? _verticalMaxOptionCount : _items.count;
                collectionHeight = _optionsRowHeight *count +count *layout.minimumLineSpacing;
            } else {
                collectionHeight = _optionsRowHeight +layout.minimumLineSpacing;
            }
        }
        _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_messageLabel.frame) +_edgeInsets.bottom, _alertWidth, collectionHeight);
    }
    
    
    CGFloat alertHeight = CGRectGetMaxY(_collectionView.frame);
    _contentView.bounds = CGRectMake(0, 0, _alertWidth, alertHeight);
    _contentView.center = CGPointMake(self.frame.size.width *.5,
                                      self.frame.size.height *.5);
}

#pragma mark -

- (void)orientationDidChange {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.frame = window.bounds;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end


@implementation TDAlertItem

-(id)initWithTitle:(NSString *)title andHandle:(itemClickBlock)handle{
    self = [super init];
    if (self) {
        _title = title;
        _font = [UIFont systemFontOfSize:12];
        _titleColor = [UIColor colorWithHexString:@"#666666"];
        _backgroundColor = [UIColor whiteColor];
        _handle = handle;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _font = [UIFont systemFontOfSize:12];
        _titleColor = [UIColor colorWithHexString:@"#666666"];
        _backgroundColor = [UIColor whiteColor];
    } return self;
}

@end
