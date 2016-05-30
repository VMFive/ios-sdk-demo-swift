//
//  NewController.m
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NewController.h"

@implementation NewController

+ (nullable UIViewController *)from:(nonnull NSString *)name {
    Class aClass = NSClassFromString(name);
    if (aClass) {
        return [aClass new];
    }
    return nil;
}

@end
