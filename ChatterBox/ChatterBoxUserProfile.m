//
//  ChatterBoxUserProfile.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/1/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "ChatterBoxUserProfile.h"

@implementation ChatterBoxUserProfile


+ (ChatterBoxUserProfile *) createNewUserProfile {
    ChatterBoxUserProfile *newProfile = [[ChatterBoxUserProfile alloc] init];
    return newProfile;
}


- (NSDictionary *) asDictionary {
    return @{ @"profileID" : self.profileID,
              @"firstName" : self.firstName,
              @"lastName" : self.lastName,
              @"location" : self.location,
              @"company" : self.company,
              @"email": @"noemail@noemail.com" //not shared
    };
}



@end
