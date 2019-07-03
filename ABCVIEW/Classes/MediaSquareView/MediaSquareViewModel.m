//
//  MediaSquareViewModel.m
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/26.
//

#import "MediaSquareViewModel.h"
#import "MediaSquareCollectionCell.h"
#import "MediaSquareAsset.h"

CGFloat MAXIMGHEIGHT_WIDTH = 180.0;

@interface MediaSquareViewModel ()

@property (nonatomic, assign) CGFloat preferWidth;

@end

@implementation MediaSquareViewModel

- (void)reloadView:(CGFloat)preferWidth caculateHeight:(void(^)(CGFloat height))caculateHeight {

    if(self.mediaArray.count == 0) {
        caculateHeight(0);
        return;
    }

    self.preferWidth = preferWidth;

    if(!self.maxRowWidth_Height)
        self.maxRowWidth_Height = 180.0;
    if(!self.columnSpace)
        self.columnSpace = 4.0;
    if(!self.lineSpace)
        self.lineSpace = 4.0;
    if(!self.columnWidth)
        self.columnWidth = 112.0;
    if(!self.rowHeight)
        self.rowHeight = 112.0;

    /*
    self.preferWidth = preferWidth;
    CGFloat itemW = ((self.preferWidth - _columnSpace * (_columnCount - 1)) / (CGFloat)_columnCount);
    CGFloat itemH = itemW;
     if(self.rowHeight != 0) {
        itemH = self.rowHeight;
     }
     */
    
    CGFloat itemH = 0;
    CGFloat itemW = 0;
    if(self.mediaArray.count > 1) {
        
        /*
         CGFloat itemW = ((self.preferWidth - _columnSpace * (_columnCount - 1)) / (CGFloat)_columnCount);
         CGFloat itemH = itemW;
         if(self.rowHeight != 0) {
         itemH = self.rowHeight;
         }
         */
        itemW = self.columnWidth;
        itemH = self.rowHeight;
        
    } else if(self.mediaArray.count == 1) {
        
        if(self.oneFixWidthOrHeight) {
            itemW = self.columnWidth;
            itemH = self.rowHeight;
        } else {
            MediaSquareAsset * asset = self.mediaArray[0];
            CGFloat assetH = asset.mediaHeight;
            CGFloat assetW = asset.mediaWidth;
            if(assetW == 0) assetW = self.columnWidth;
            if(assetH == 0) assetH = self.rowHeight;
            if (asset.mediaFrom == MEDIA_FROM_NOTE) {
                itemW = self.noteRowWidth;
                itemH = self.noteRowHeight;
            }
            else if (self.maxRowWidth_Height && asset.mediaFrom != MEDIA_FROM_NOTE)
            {
                CGFloat maxScale = MAX(assetW/self.maxRowWidth_Height, assetH/self.maxRowWidth_Height);
                itemW = assetW / maxScale;
                itemH = assetH / maxScale;
            }
        }
    }
    
    NSInteger rowNum = ceilf(self.mediaArray.count / (CGFloat)self.columnCount);
    if(self.mediaArray.count == 4) {
        rowNum = 2;
    }
    if(self.maxRowNum == 0)
        self.maxRowNum = 3;
    if(rowNum > self.maxRowNum)
        rowNum = self.maxRowNum;
    CGFloat height = (rowNum - 1) * self.lineSpace + rowNum * itemH;
    caculateHeight(height);
}

#pragma mark |---> UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MediaSquareCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYMediaSquareCollectionCell" forIndexPath:indexPath];
    cell.themStyle = self.themStyle;
    
    MediaSquareAsset * asset = self.mediaArray[indexPath.row];
    cell.mediaWidth = asset.mediaWidth ?: self.columnWidth;
    cell.mediaHeight = asset.mediaHeight ?: self.rowHeight;
    cell.mediaThumURLString = asset.mediaThumURLString;
    cell.mediaURLString = asset.mediaURLString;
    cell.mediaSquareType = asset.mediaSquareType;
    cell.cornerSize = self.cornerSize;
    cell.playTimeType = asset.playTimeType;
    cell.playTime = asset.playTime;
    cell.exceptionText = asset.exceptionText;
    cell.mediaFrom = asset.mediaFrom;
    
    NSInteger maxCountShow = self.maxRowNum * self.columnCount;
    if(indexPath.row == (maxCountShow - 1) && self.mediaArray.count > maxCountShow) {
        cell.showMore = YES;
    } else {
        cell.showMore = NO;
    }
    [cell makeUp];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MediaSquareAsset * asset = self.mediaArray[indexPath.row];
    if(asset.exceptionText && asset.exceptionText.length) {
        return;
    }
    BOOL isMore = NO;
    NSInteger maxCountShow = self.maxRowNum * self.columnCount;
    if(indexPath.row == maxCountShow - 1 && self.mediaArray.count > maxCountShow) {
        isMore = YES;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectMediaData:totalMediaData:index:isMore:)]) {
        [self.delegate selectMediaData:asset totalMediaData:self.mediaArray index:indexPath.row isMore:isMore];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemH = 0;
    CGFloat itemW = 0;
    if(self.mediaArray.count > 1) {
        
        /*
         CGFloat itemW = ((self.preferWidth - _columnSpace * (_columnCount - 1)) / (CGFloat)_columnCount);
         CGFloat itemH = itemW;
         if(self.rowHeight != 0) {
            itemH = self.rowHeight;
         }
         */
        itemW = self.columnWidth;
        itemH = self.rowHeight;
        
    } else if(self.mediaArray.count == 1) {
        
        if(self.oneFixWidthOrHeight) {
            itemW = self.columnWidth;
            itemH = self.rowHeight;
        } else {
            MediaSquareAsset * asset = self.mediaArray[indexPath.row];
            CGFloat assetH = asset.mediaHeight;
            CGFloat assetW = asset.mediaWidth;
            if(assetW == 0) assetW = self.columnWidth;
            if(assetH == 0) assetH = self.rowHeight;
            if (asset.mediaFrom == MEDIA_FROM_NOTE) {
                itemW = self.noteRowWidth;
                itemH = self.noteRowHeight;
            }
            else if(self.maxRowWidth_Height && asset.mediaFrom != MEDIA_FROM_NOTE)
            {
                CGFloat maxScale = MAX(assetW/self.maxRowWidth_Height, assetH/self.maxRowWidth_Height);
                itemW = assetW / maxScale;
                itemH = assetH / maxScale;
            }
        }
    }
    return CGSizeMake(itemW, itemH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    if(self.mediaArray.count == 1) {
        CGFloat itemH = 0;
        CGFloat itemW = 0;
        if(self.oneFixWidthOrHeight) {
            itemW = self.columnWidth;
            itemH = self.rowHeight;
        } else {
            MediaSquareAsset * asset = self.mediaArray[0];
            CGFloat assetH = asset.mediaHeight;
            CGFloat assetW = asset.mediaWidth;
            if(assetW == 0) assetW = self.columnWidth;
            if(assetH == 0) assetH = self.rowHeight;

            if (asset.mediaFrom == MEDIA_FROM_NOTE) {
                itemW = self.noteRowWidth;
                itemH = self.noteRowHeight;
                return UIEdgeInsetsMake(0, 0, 0, 0);
            }
            else if (self.maxRowWidth_Height && asset.mediaFrom != MEDIA_FROM_NOTE)
            {
                CGFloat maxScale = MAX(assetW/self.maxRowWidth_Height, assetH/self.maxRowWidth_Height);
                itemW = assetW / maxScale;
                itemH = assetH / maxScale;
                if(itemW >= itemH) {
                    return UIEdgeInsetsMake(0, -(self.preferWidth - itemW)/2.0, 0, (self.preferWidth - itemW)/2.0);
                } else {
                    return UIEdgeInsetsMake(0, 0, 0, 0);
                }
            }
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.columnSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.lineSpace;
}

@end
