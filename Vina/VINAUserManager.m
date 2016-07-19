//
//  VINAUserManager.m
//  Vina
//
//  Created by Yael Rubinstein on 7/19/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

#import "VINAUserManager.h"

@implementation VINAUserManager

+ (instancetype)sharedUserManager
{
    static dispatch_once_t sharedUserManagerOnceToken;
    static VINAUserManager *sharedUserManager;
    
    dispatch_once(&sharedUserManagerOnceToken, ^{
        sharedUserManager = [[self alloc] init];
    });
    
    return sharedUserManager;
}

@end
