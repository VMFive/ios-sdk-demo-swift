//
//  VMFiveNativeVideoAdAdapter.h
//  MoPubSDK
//
//  Created by Blake Pai on 11/17/15.
//  Copyright © 2015 MoPub. All rights reserved.
//

#import "MPNativeAdAdapter.h"

@class VANativeAd;
@interface VMFiveNativeVideoAdAdapter : NSObject <MPNativeAdAdapter>

@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;
@property (nonatomic, readonly) NSArray *impressionTrackerURLs;
@property (nonatomic, readonly) NSArray *clickTrackerURLs;

+ (NSString *)version;

- (instancetype)initWithNativeAd:(VANativeAd *)natvieAd withOtherInfos:(NSDictionary *)otherInfos;
- (instancetype)initWithAdProperties:(NSMutableDictionary *)properties;

- (void)handleVideoViewImpression;
- (void)handleVideoViewClick;
- (void)handleVideoHasProgressedToTime:(NSTimeInterval)playbackTime;

@end
