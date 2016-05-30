//
//  VANativeAd+FullscreenIcon.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "VANativeAd+FullscreenIcon.h"

@implementation VANativeAd (FullscreenIcon)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

#pragma mark - Private Instance Method

- (id)mediaConfigObject {
    return [self performSelector:@selector(mediaConfig)];
}

#pragma mark - Property

- (void)setIsNeedFullscreenIcon:(BOOL)isNeedFullscreenIcon {
    id mediaConfig = [self mediaConfigObject];
    SEL targetSelector = @selector(setIsNeedFullscreenIcon:);
    NSMethodSignature *methodSignature = [mediaConfig methodSignatureForSelector:targetSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = mediaConfig;
    invocation.selector = targetSelector;
    [invocation setArgument:&isNeedFullscreenIcon atIndex:2];
    [invocation invoke];
}

- (BOOL)isNeedFullscreenIcon {
    id mediaConfig = [self mediaConfigObject];
    SEL targetSelector = @selector(isNeedFullscreenIcon);
    NSMethodSignature *methodSignature = [mediaConfig methodSignatureForSelector:targetSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = mediaConfig;
    invocation.selector = targetSelector;
    [invocation invoke];
    BOOL isNeedFullscreenIcon;
    [invocation getReturnValue:&isNeedFullscreenIcon];
    return isNeedFullscreenIcon;
}

#pragma clang diagnostic pop

@end
