//
//  MediaSquareCollectionCell.m
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import "MediaSquareCollectionCell.h"
#import "UIImage+bundle.h"
#import "NSBundle+MediaSquare.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import <WYBaseFrameWork/UIImage+Color.h>
#import <WYBaseFrameWork/UIImage+SVG.h>
#import <WYBaseFrameWork/UIColor+FromHex.h>
#import <WYBaseFrameWork/UIFont+WY.h>
#import <WYBaseFrameWork/NSString+Time.h>
#import "MediaSquareTimeLabel.h"

@interface MediaSquareCollectionCell ()

@property (nonatomic, strong) UIImageView * thumImageView;

@property (nonatomic, strong) UIButton * playTimeBtn;

@property (nonatomic, strong) UILabel * moreLabel;

@property (nonatomic, strong) MediaSquareTimeLabel * commentTime;

@property (nonatomic, strong) UIImageView * playVideoImageView;

@property (nonatomic, strong) UILabel * exceptionLabel;

@end

@implementation MediaSquareCollectionCell

- (void)layoutSubviews {

    [super layoutSubviews];

    if([self.thumImageView isDescendantOfView:self.contentView] == NO) {
        [self.contentView addSubview:self.thumImageView];
    }
    self.thumImageView.frame = self.bounds;
    
    
    if (self.mediaFrom == MEDIA_FROM_NOTE) {
        //笔记样式
        if ([self.commentTime isDescendantOfView:self.thumImageView]) {
            [self.commentTime removeFromSuperview];
        }
        
        if(self.mediaSquareType == eMediaSqureTypeVideo) {
            
            if([self.playVideoImageView isDescendantOfView:self.contentView] == NO) {
                [self.contentView addSubview:self.playVideoImageView];
            }
            
            CGFloat x = (CGRectGetWidth(self.frame) - 30) / 2.0;
            CGFloat y = (CGRectGetHeight(self.frame) - 30) / 2.0;
            self.playVideoImageView.frame = CGRectMake(x, y, 30, 30);
            
        } else {
            
            [self.playVideoImageView removeFromSuperview];
        }
        if(self.playTime && self.playTime.length) {
            
            if([self.playTimeBtn isDescendantOfView:self.thumImageView] == NO) {
                [self.thumImageView addSubview:self.playTimeBtn];
            }
            
            NSString * playTimeType = @"笔记";
            if(self.playTimeType && self.playTimeType.length) {
                playTimeType = self.playTimeType;
            }
            NSString * timeStr = [NSString timeSecondsConvertToTimeString:self.playTime.integerValue idDot:YES];
            NSString * showStr = [NSString stringWithFormat:@"%@ | %@",playTimeType,timeStr];
            
            [self.playTimeBtn setTitle:showStr forState:UIControlStateNormal];
            [self.playTimeBtn sizeToFit];
            self.playTimeBtn.frame = CGRectMake(CGRectGetWidth(self.thumImageView.frame) - 8 - CGRectGetWidth(self.playTimeBtn.frame), 0, CGRectGetWidth(self.playTimeBtn.frame), 23);
        } else {
            
            [self.playTimeBtn removeFromSuperview];
        }
       
    }
    else
    {
        //笔记意外的其他样式
        if([self.playVideoImageView isDescendantOfView:self.contentView] == YES) {
            [self.playVideoImageView removeFromSuperview];
        }
        if ([self.playTimeBtn isDescendantOfView:self.thumImageView]) {
            [self.playTimeBtn removeFromSuperview];
        }
        
        
        if(self.playTime && self.playTime.length) {
            
            if([self.commentTime isDescendantOfView:self.thumImageView] == NO) {
                [self.thumImageView addSubview:self.commentTime];
            }
            
            [self.commentTime setText:self.playTime];
            self.commentTime.frame = CGRectMake(CGRectGetWidth(self.thumImageView.frame) - 7 - CGRectGetWidth(self.commentTime.frame), CGRectGetHeight(self.thumImageView.frame) - 7 - CGRectGetHeight(self.commentTime.frame), self.commentTime.frame.size.width, self.commentTime.frame.size.height);
        } else {
            
            [self.commentTime removeFromSuperview];
        }
    }
    
    
    if(self.showMore) {
        
        if(self.mediaSquareType == eMediaSqureTypeVideo) {
            [self.playVideoImageView removeFromSuperview];
        }
        [self.exceptionLabel removeFromSuperview];
        
        if([self.moreLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:self.moreLabel];
            self.moreLabel.layer.cornerRadius= self.cornerSize;
            self.moreLabel.layer.masksToBounds = YES;
        }
        
        self.moreLabel.frame = self.bounds;

    }
    else  if(self.exceptionText && self.exceptionText.length) {
        
        if(self.mediaSquareType == eMediaSqureTypeVideo) {
            [self.playVideoImageView removeFromSuperview];
        }

        [self.moreLabel removeFromSuperview];
        
        if([self.exceptionLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:self.exceptionLabel];
            self.exceptionLabel.layer.cornerRadius= self.cornerSize;
            self.exceptionLabel.layer.masksToBounds = YES;
        }
        
        self.exceptionLabel.text = self.exceptionText;
        self.exceptionLabel.frame = self.bounds;
    }
    else {

        [self.exceptionLabel removeFromSuperview];

        [self.moreLabel removeFromSuperview];
    }
}

- (void)makeUp {
    
    [self setNeedsLayout];
    
    self.thumImageView.layer.cornerRadius= self.cornerSize;
    self.thumImageView.layer.masksToBounds = YES;
    
    [self.thumImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    UIImage * placeHolderImg = nil;
    if(self.themStyle == eMediaSquareThemStyleDark) {
        placeHolderImg = [UIImage imageWithColor:[UIColor colorwithHexString:@"#222222" alpha:1] imageSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.moreLabel.backgroundColor = [UIColor colorwithHexString:@"#151515" alpha:1];
        self.moreLabel.textColor = [UIColor colorwithHexString:@"#076B92" alpha:1];
    } else {
        placeHolderImg = [UIImage imageWithColor:[UIColor colorwithHexString:@"#DCDDDD" alpha:1] imageSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.moreLabel.backgroundColor = [UIColor colorwithHexString:@"#DCDDDD" alpha:1];
        self.moreLabel.textColor = [UIColor colorWithRed:100/255.0 green:131/255.0 blue:233/255.0 alpha:1.0];
    }

    [self.thumImageView sd_setImageWithURL:[NSURL URLWithString:self.mediaThumURLString] placeholderImage:placeHolderImg];
}

- (UIImageView *)thumImageView {
    
    if (!_thumImageView) {
        _thumImageView = [[UIImageView alloc] init];
        _thumImageView.userInteractionEnabled = YES;
//        _thumImageView.clipsToBounds = YES;
    }
    return _thumImageView;
}

- (UIButton *)playTimeBtn {

    if (!_playTimeBtn) {
        _playTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playTimeBtn.enabled = NO;
        [_playTimeBtn setBackgroundImage:[UIImage svgImageNamed:@"MediaSquare_playTime_bg" imageSize:CGSizeMake(90, 23) inBundle_wy:[NSBundle wyMediaSquareBundle]] forState:UIControlStateNormal];
        [_playTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playTimeBtn.titleLabel setFont:[UIFont font_systemRegularFontWithSize:13.0]];
    }
    return _playTimeBtn;
}

-(MediaSquareTimeLabel *)commentTime
{
    if (!_commentTime) {
        _commentTime = [[MediaSquareTimeLabel alloc]init];
    }
    return _commentTime;
}

- (UIImageView *)playVideoImageView {
    
    if (!_playVideoImageView) {
        _playVideoImageView = [[UIImageView alloc] init];
        _playVideoImageView.image = [UIImage svgImageNamed:@"icon_play" inBundle_wy:[NSBundle wyMediaSquareBundle]];
       // _playVideoImageView.image = [UIImage imageNamed:@"icon_play" inBundle_wy:[NSBundle wyMediaSquareBundle]];
        _playVideoImageView.userInteractionEnabled = YES;
    }
    return _playVideoImageView;
}

- (UILabel *)moreLabel {
    
    if(_moreLabel == nil) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.numberOfLines = 0;
        _moreLabel.textColor = [UIColor whiteColor];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        _moreLabel.font = [UIFont font_systemRegularFontWithSize:14.0f];
        _moreLabel.text = @"查看更多";
        _moreLabel.backgroundColor = [UIColor colorwithHexString:@"#DCDDDD" alpha:1];
        _moreLabel.textColor = [UIColor colorWithRed:100/255.0 green:131/255.0 blue:233/255.0 alpha:1.0];
    }
    return _moreLabel;
}

- (UILabel *)exceptionLabel {
    
    if(_exceptionLabel == nil) {
        _exceptionLabel = [[UILabel alloc] init];
        _exceptionLabel.numberOfLines = 0;
        _exceptionLabel.textColor = [UIColor whiteColor];
        _exceptionLabel.textAlignment = NSTextAlignmentCenter;
        _exceptionLabel.font = [UIFont font_systemRegularFontWithSize:14.0f];
        _exceptionLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _exceptionLabel;
}

@end
