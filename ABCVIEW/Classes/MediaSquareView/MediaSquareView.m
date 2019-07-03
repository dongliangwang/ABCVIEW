//
//  MediaSquareView.m
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import "MediaSquareView.h"
#import "MediaSquareCollectionCell.h"

@interface MediaSquareView ()

/// 九宫格视图-用collectionview来展示.
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation MediaSquareView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    if([self.collectionView isDescendantOfView:self.contentView] == NO) {
        [self.contentView addSubview:self.collectionView];
    }
}

- (void)reloadView:(MediaSquareViewModel *)viewModel
       preferWidth:(CGFloat)preferWidth
    caculateHeight:(void(^)(CGFloat height))caculateHeight {
    
    if(viewModel.mediaArray.count > 1) {
        
        CGFloat actWith = 0;
        if(viewModel.mediaArray.count == 4) {
            actWith = 2 * viewModel.columnWidth + viewModel.columnSpace;
        } else {
            actWith = viewModel.columnCount * viewModel.columnWidth + (viewModel.columnCount - 1) * viewModel.columnSpace;
        }
        if(actWith < preferWidth) {
            preferWidth = actWith;
        } else if (actWith > preferWidth) {
            viewModel.columnWidth = (preferWidth - (viewModel.columnCount - 1) * viewModel.columnSpace)/(CGFloat)viewModel.columnCount;
        }
    } else if (viewModel.mediaArray.count == 1) {
        
        if(viewModel.columnWidth > preferWidth)
            viewModel.columnWidth = preferWidth;

        CGFloat itemH = 0;
        CGFloat itemW = 0;
        if(viewModel.oneFixWidthOrHeight) {
            itemW = viewModel.columnWidth;
            itemH = viewModel.rowHeight;
        } else {
            MediaSquareAsset * asset = viewModel.mediaArray[0];
            CGFloat assetH = asset.mediaHeight;
            CGFloat assetW = asset.mediaWidth;
            if(assetW == 0) assetW = viewModel.columnWidth;
            if(assetH == 0) assetH = viewModel.rowHeight;
            if (asset.mediaFrom == MEDIA_FROM_NOTE) {
                if(viewModel.noteRowWidth > preferWidth)
                    viewModel.noteRowWidth = preferWidth;
                itemW = viewModel.noteRowWidth;
                itemH = viewModel.noteRowHeight;
            }
            else if(viewModel.maxRowWidth_Height && asset.mediaFrom != MEDIA_FROM_NOTE)
            {
                CGFloat maxScale = MAX(assetW/viewModel.maxRowWidth_Height, assetH/viewModel.maxRowWidth_Height);
                itemW = assetW / maxScale;
                itemH = assetH / maxScale;
            }
        }
        preferWidth = itemW;
    }
    
    CGRect frame = self.frame;
    frame.size.width = preferWidth;
    self.frame = frame;
    self.contentView.bounds = self.bounds;

    self.viewModel = viewModel;
    __block CGFloat height_ = 0;
    [self.viewModel reloadView:CGRectGetWidth(self.bounds) caculateHeight:^(CGFloat height) {
        height_ = height;
    }];
    caculateHeight(height_);
    

    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), height_);
    [self.collectionView reloadData];
}

#pragma mark setter&getter
- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            [_collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        [_collectionView registerClass:[MediaSquareCollectionCell class] forCellWithReuseIdentifier:@"WYMediaSquareCollectionCell"];
    }
    _collectionView.delegate = self.viewModel;
    _collectionView.dataSource = self.viewModel;
    return _collectionView;
}

@end
