//
//  MediaSquareTimeLabel.m
//  MediaSquareView
//
//  Created by Allin372 on 2019/6/18.
//

#import "MediaSquareTimeLabel.h"
#import <WYBaseFrameWork/UIFont+WY.h>
#import <WYBaseFrameWork/UIImage+SVG.h>
#import <WYBaseFrameWork/UIView+Utility.h>
#import "NSBundle+MediaSquare.h"

@interface MediaSquareTimeLabel ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imagev;

@end

@implementation MediaSquareTimeLabel
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 
 // Drawing code
 }
 */
- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.layer.cornerRadius    = 8.0;
        self.layer.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.2].CGColor;
        [self setUpView];
    }
    return self;
}
- (void)setUpView {
    
    _imagev       = [[UIImageView alloc] initWithFrame:CGRectMake(6, 4, 7, 8)];
    _imagev.image = [UIImage svgImageNamed:@"videoTime" inBundle_wy:[NSBundle wyMediaSquareBundle]];;
    [self addSubview:_imagev];
    _label       = [[UILabel alloc] init];
    _label.frame = CGRectMake(6 + 7 + 3, 1, 27, 14);
    _label.font  = [UIFont systemFontOfSize:10];
    //_label.font = [UIFont systemFontOfSize:5 weight:10];
    _label.textColor       = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1.0];
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];
}
- (void)setText:(NSString *)text {
    
    if (!_hideImage) {
        //有三角图标
        _imagev.hidden = NO;
        _label.text    = text;
        _label.frame   = CGRectMake(6 + 7 + 3, 1, 27, 14);
        [_label sizeToFit];
        self.frame     = CGRectMake(0, 0, 6 + 7 + 3 + CGRectGetWidth(_label.frame) + 6, 16);
        _label.centerY = self.height / 2;
    } else {
        _imagev.hidden = YES;
        _label.frame   = CGRectMake(6, 1, 27, 14);
        _label.text    = text;
        _label.frame   = CGRectMake(6, 1, 27, 14);
        [_label sizeToFit];
        self.frame     = CGRectMake(0, 0, 6 + CGRectGetWidth(_label.frame) + 6, 16);
        _label.centerY = self.height / 2;
    }
}
- (void)setHideImage:(BOOL)hideImage {
    
    _hideImage = hideImage;
    if (!_hideImage) {
        //有三角图标
        _imagev.hidden = NO;
        _label.frame   = CGRectMake(6 + 7 + 3, 1, _label.width, _label.height);
        self.frame     = CGRectMake(0, 0, 6 + 7 + 3 + CGRectGetWidth(_label.frame) + 6, 16);
        _label.centerY = self.height / 2;
    } else {
        _imagev.hidden = YES;
        _label.frame   = CGRectMake(6, 1, _label.width, _label.height);
        self.frame     = CGRectMake(0, 0, 6 + CGRectGetWidth(_label.frame) + 6, 16);
        _label.centerY = self.height / 2;
    }
}
- (BOOL)hideImage {
    
    return _hideImage;
}

@end
