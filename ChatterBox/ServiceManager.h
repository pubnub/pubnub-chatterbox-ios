//
//  ServiceManager.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/23/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileService.h"
#import "ChatterBoxService.h"

@interface ServiceManager : NSObject

@property(atomic) ProfileService *profileService;
@property(atomic) ChatterBoxService *chatterService;

+ (id) sharedInstance;

@end
