//
//  ProfileService.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/1/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatterBoxUserProfile.h"

typedef void (^ProfileServiceCompletionBlock)(NSError *error, ChatterBoxUserProfile *profile);

@interface ProfileService : NSObject

/**
 * create a shared instance of the ProfileService
**/
+ (id) sharedInstance;

- (BOOL) addProfile: (ChatterBoxUserProfile *)profile withCompletionBlock: (ProfileServiceCompletionBlock)block;

- (ChatterBoxUserProfile *) registerNewUserProfile: (NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;


- (void) authenticateUser: (NSString *)username password: (NSString *)password  withCompletionBlock: (ProfileServiceCompletionBlock)block;


@end