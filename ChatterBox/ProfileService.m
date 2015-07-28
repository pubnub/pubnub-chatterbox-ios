//
//  ProfileService.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/1/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <AFNetworking/AFNetworking.h>

#import "ProfileService.h"
#import "ChatterBoxUserProfile.h"


@implementation ProfileService

//TODO: Fix this so it comes from preferences so I can have a dev,prod environment
static NSString * const ProfileServiceBaseURL = @"http://localhost:5000/profile";

+ (id) sharedInstance {
    static ProfileService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance configure];
    });
    
    return sharedInstance;
}

- (void) configure {
    NSLog(@"inside configure for shared instance of ProfileService");
}


- (ChatterBoxUserProfile *) registerNewUserProfile: (NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    
    ChatterBoxUserProfile *chatterBoxUserProfile = [[ChatterBoxUserProfile alloc] init];
    chatterBoxUserProfile.firstName = firstName;
    chatterBoxUserProfile.lastName = lastName;
    chatterBoxUserProfile.email = email;
    chatterBoxUserProfile.enabled = true;
    
    
    [self addProfile:chatterBoxUserProfile withCompletionBlock:^(NSError *error, ChatterBoxUserProfile *profile) {
        NSLog(@"inside callback with %@", profile);
    }];
    
    
    return chatterBoxUserProfile;
}

- (BOOL ) addProfile: (ChatterBoxUserProfile *) profile withCompletionBlock:(ProfileServiceCompletionBlock)block {
    
    BOOL result = NO;
    NSURL *url = [NSURL URLWithString: ProfileServiceBaseURL];
    NSDictionary *params = @{ @"firstName": profile.firstName,
                              @"lastName": profile.lastName,
                              @"email":  profile.email};
    
    
    
    AFHTTPSessionManager *manager  = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer      = [AFJSONRequestSerializer serializer];
    manager.responseSerializer     = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"/profile" parameters: params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"inside success %@",responseObject);
        if(block != nil){
            DDLogDebug(@"response object classname %@",[responseObject class]);;
            block(nil,nil);
        }
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"inside failure %@", error);
    }];
    
    return result;
}


- (void) authenticateUser: (NSString *)username password: (NSString *)password withCompletionBlock: (ProfileServiceCompletionBlock )completionBlock {
    
    NSURL *url = [NSURL URLWithString: ProfileServiceBaseURL];
    NSDictionary *params = @{ @"username": username,
                              @"password": password};
    
    
    AFHTTPSessionManager *manager  = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer      = [AFJSONRequestSerializer serializer];
    manager.responseSerializer     = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password: password];
    [manager.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:@"/chatterbox/v1/api/profile/auth" parameters: params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"inside success %@",responseObject);
        if(completionBlock != nil){
            completionBlock(nil,[[ChatterBoxUserProfile alloc] init]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          NSLog(@"inside failure %@", error.debugDescription);
    }];

}




@end

