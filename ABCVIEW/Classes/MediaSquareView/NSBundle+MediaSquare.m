//
//  NSBundle+MediaSquare.m
//  AFNetworking
//
//  Created by ZhangKaiChao on 2018/9/25.
//

#import "NSBundle+MediaSquare.h"
#import "MediaSquareView.h"

@implementation NSBundle (MediaSquare)

+ (instancetype)wyMediaSquareBundle {
    
    static NSBundle * wyMediaSquareBundle = nil;
    if (wyMediaSquareBundle == nil) {
        wyMediaSquareBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MediaSquareView class]] resourcePath]];
    }
    return wyMediaSquareBundle;
}

@end
