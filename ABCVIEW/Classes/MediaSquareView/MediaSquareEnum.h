//
//  MediaSquareEnum.h
//  Pods
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#ifndef MediaSquareEnum_h
#define MediaSquareEnum_h

typedef enum : NSUInteger {
    eMediaSqureTypeVideo = 1,
    eMediaSqureTypeImg = 2
} MediaSquareType;

/**
 主题色调
 V3.7.0 唯医学院课新增dark样式
 
 - eMediaSquareThemStyleLight: 浅色调
 - eMediaSquareThemStyleDark: 深色调
 */
typedef NS_ENUM(NSUInteger, MediaSquareThemStyle) {
    
    eMediaSquareThemStyleLight,
    eMediaSquareThemStyleDark,
};

typedef enum {
    MEDIA_FROM_DFALLT,
    MEDIA_FROM_COMMENT ,//来自评论的九宫格
    MEDIA_FROM_NOTE, //来自笔记的九宫格
    MEDIA_FROM_YUNYUN,//来自骨人云的九宫格
    MEDIA_FROM_STATION //来自工作站的九宫格
}MEDIA_FROM;

#endif /* MediaSquareEnum_h */
