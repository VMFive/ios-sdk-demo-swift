//
//  VANativeAd+IconAlignment.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/7/13.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "VANativeAd+IconAlignment.h"

@implementation VANativeAd (IconAlignment)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

#pragma mark - Private Instance Method

- (id)mediaConfigObject {
    return [self performSelector:@selector(mediaConfig)];
}

#pragma mark - Property

- (void)setVideoItemsAlignment:(NSInteger)videoItemsAlignment {
    id mediaConfig = [self mediaConfigObject];
    SEL targetSelector = @selector(setVideoItemsAlignment:);
    NSMethodSignature *methodSignature = [mediaConfig methodSignatureForSelector:targetSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = mediaConfig;
    invocation.selector = targetSelector;
    [invocation setArgument:&videoItemsAlignment atIndex:2];
    [invocation invoke];
}

- (NSInteger)videoItemsAlignment {
    id mediaConfig = [self mediaConfigObject];
    SEL targetSelector = @selector(videoItemsAlignment);
    NSMethodSignature *methodSignature = [mediaConfig methodSignatureForSelector:targetSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = mediaConfig;
    invocation.selector = targetSelector;
    [invocation invoke];
    NSInteger videoItemsAlignment;
    [invocation getReturnValue:&videoItemsAlignment];
    return videoItemsAlignment;
}

#pragma clang diagnostic pop

@end
