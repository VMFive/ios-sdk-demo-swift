//
//  VMFiveSplashCustomEvent.h
//  VMFiveAdNetworkMoPubAdapter
//
//  Created by DaidoujiChen on 2017/9/15.
//  Copyright © 2017年 VMFive. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif

@interface VMFiveSplashCustomEvent : MPInterstitialCustomEvent

+ (NSString *)version;

@end
