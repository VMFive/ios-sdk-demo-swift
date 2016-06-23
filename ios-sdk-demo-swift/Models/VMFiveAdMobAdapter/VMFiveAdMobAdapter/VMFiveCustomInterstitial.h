//
//  VMFiveCustomInterstitial.h
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
#import "VAAdInterstitial.h"
#endif



@interface VMFiveCustomInterstitial : NSObject <GADCustomEventInterstitial, VAAdInterstitialDelegate>

@property (nonatomic, strong) VAAdInterstitial *vfInterstital;

+ (NSString *)version;

@end
