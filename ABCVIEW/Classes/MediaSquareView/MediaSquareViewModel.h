//
//  MediaSquareViewModel.h
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/26.
//

#import <Foundation/Foundation.h>
#import "MediaSquareAsset.h"

@protocol MediaSquareViewDelegate <NSObject>

- (void)selectMediaData:(MediaSquareAsset *)mediaData
         totalMediaData:(NSArray *)totalMediaData
                  index:(NSInteger)index
                 isMore:(BOOL)isMore;

@end

@interface MediaSquareViewModel : NSObject
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

/// 色调.
@property (nonatomic, assign) MediaSquareThemStyle themStyle;

/// 传-每行个数.
@property (nonatomic, assign) NSInteger columnCount;

/// 传-最多几行.
@property (nonatomic, assign) NSInteger maxRowNum;

/// 传-九宫格列宽.
@property (nonatomic, assign) NSInteger columnWidth;

/// 传-九宫格行高（默认是和九宫格列宽一样）.
@property (nonatomic, assign) NSInteger rowHeight;

/// 传-最大行高 列宽.
@property (nonatomic, assign) NSInteger maxRowWidth_Height;

/// 传-笔记 宽.
@property (nonatomic, assign) NSInteger noteRowWidth;

/// 传-笔记 行高.
@property (nonatomic, assign) NSInteger noteRowHeight;

/// 传-列间距.
@property (nonatomic, assign) CGFloat columnSpace;

/// 传-行间距.
@property (nonatomic, assign) CGFloat lineSpace;

/// 传- 针对一张图/视频缩略图 是否固定宽高（如果固定就取columnWidth 和 rowHeight）.
@property (nonatomic, assign) BOOL oneFixWidthOrHeight;

/// 圆角大小.
@property (nonatomic, assign) CGFloat cornerSize;

/// 传-数据源.
@property (nonatomic, strong) NSMutableArray<MediaSquareAsset *> * mediaArray;

/// 传-事件代理
@property (nonatomic, weak) id <MediaSquareViewDelegate> delegate;

/**
 求高

 @param caculateHeight 视图计算求的高
 */
- (void)reloadView:(CGFloat)preferWidth caculateHeight:(void(^)(CGFloat height))caculateHeight;

@end
