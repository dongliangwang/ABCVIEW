//
//  MediaSquareAsset.h
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import <Foundation/Foundation.h>
#import "MediaSquareEnum.h"

/// 九宫格Asset.
@interface MediaSquareAsset : NSObject

/// 资源类型.
@property (nonatomic, assign) MediaSquareType mediaSquareType;

/// 资源缩略图宽.
@property (nonatomic, assign) CGFloat mediaWidth;

/// 资源缩略图高.
@property (nonatomic, assign) CGFloat mediaHeight;

/// 资源大小.
@property (nonatomic, assign) CGFloat mediaSize;

/// 资源缩略图URL.
@property (nonatomic, copy) NSString * mediaThumURLString;

/// 资源URL.
@property (nonatomic, copy) NSString * mediaURLString;

/// 资源描述.
@property (nonatomic, copy) NSString * mediaDesc;

/// PlayTime类型-默认为 "笔记".
@property (nonatomic, copy) NSString * playTimeType;

/// PlayTime.
@property (nonatomic, copy) NSString * playTime;

/// 异常文本.
@property (nonatomic, copy) NSString * exceptionText;
/// 1表示来自评论
@property (nonatomic, assign) MEDIA_FROM  mediaFrom;

/// 扩展数据.
@property (nonatomic, strong) NSDictionary * extInfo;

@end
