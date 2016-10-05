//
//  VMFiveCustomBanner.h
//  VFAdnAdMobAdapter
//
//  Created by Blake Pai on 10/16/15.
//  Copyright © 2015 VMFive. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMobileAds;

#if IS_FRAMEWORK
@import VMFiveAdNetwork;
#else
#import "VAAdView.h"
#endif

@interface VMFiveCustomBanner : NSObject <GADCustomEventBanner, VAAdViewDelegate>

@property (nonatomic, strong) VAAdView *vfBanner;

+(NSString *)version;

@end
