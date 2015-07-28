//
//  ServiceManager.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/23/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager


//TODO: Profile and ChatterBox services don't need to be singletons. They can be managed by
//service manager

+ (id) sharedInstance {
    
        static ServiceManager *sharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[self alloc] init];
            sharedInstance.profileService = [ProfileService sharedInstance];
            sharedInstance.chatterService = [ChatterBoxService sharedInstance];
        });
        
        return sharedInstance;
}

    



@end
