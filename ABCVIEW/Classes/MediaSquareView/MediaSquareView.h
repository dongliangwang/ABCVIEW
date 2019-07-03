//
//  MediaSquareView.h
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import <UIKit/UIKit.h>
#import "MediaSquareViewModel.h"

@interface MediaSquareView : UITableViewCell

/// 数据.
@property (nonatomic, strong) MediaSquareViewModel * viewModel;

/**
  刷新视图

 @param viewModel 数据
 @param preferWidth 视图最大的宽
 @param caculateHeight 视图计算求的高
 */
- (void)reloadView:(MediaSquareViewModel *)viewModel
       preferWidth:(CGFloat)preferWidth
    caculateHeight:(void(^)(CGFloat height))caculateHeight;

@end
