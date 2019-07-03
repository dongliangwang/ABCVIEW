//
//  MediaSquareCollectionCell.h
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import <UIKit/UIKit.h>
#import "MediaSquareEnum.h"

/// 九宫格单个Asset cell.
@interface MediaSquareCollectionCell : UICollectionViewCell

/// 色调.
@property (nonatomic, assign) MediaSquareThemStyle themStyle;

/// 资源类型.
@property (nonatomic, assign) MediaSquareType mediaSquareType;

/// 来自哪个业务模块.
@property (nonatomic, assign) MEDIA_FROM mediaFrom;

/// 资源缩略图宽.
@property (nonatomic, assign) CGFloat mediaWidth;

/// 资源缩略图高.
@property (nonatomic, assign) CGFloat mediaHeight;

/// 资源缩略图URL.
@property (nonatomic, copy) NSString * mediaThumURLString;

/// 资源URL.
@property (nonatomic, copy) NSString * mediaURLString;

/// PlayTime类型-默认为 "笔记".
@property (nonatomic, copy) NSString * playTimeType;

/// PlayTime.
@property (nonatomic, copy) NSString * playTime;

/// 是否显示更多.
@property (nonatomic, assign) BOOL showMore;

/// 圆角大小.
@property (nonatomic, assign) CGFloat cornerSize;

/// 异常文本.
@property (nonatomic, copy) NSString * exceptionText;

/// 构建视图-外部调用-参数传完了后最后再调.
- (void)makeUp;

@end
