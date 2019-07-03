//
//  MediaSquareTimeLabel.h
//  MediaSquareView
//
//  Created by Allin372 on 2019/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface MediaSquareTimeLabel : UIView
//是否有三角图标
{
    BOOL _hideImage;
}
@property(assign,nonatomic)BOOL hideImage;
-(void)setText:(NSString*)text;

@end


NS_ASSUME_NONNULL_END
