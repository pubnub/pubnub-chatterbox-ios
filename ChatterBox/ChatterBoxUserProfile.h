//
//  ChatterBoxUserProfile.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/1/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatterBoxUserProfile : NSObject

@property(nonatomic)  NSString *profileID;
@property(nonatomic)  NSString *firstName;
@property(nonatomic)  NSString *lastName;
@property(nonatomic)  NSString *email;
@property(nonatomic)  BOOL enabled;
@property(nonatomic)  NSString *company;
@property(nonatomic)  NSString *location;
@property(nonatomic)  NSString *password;


//Currently not used
@property(nonatomic)  NSArray *connections;
@property(nonatomic)  NSString *authKey;

- (NSDictionary *) asDictionary;


@end
