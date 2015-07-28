//
//  ChatterBoxMessage.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/22/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "ChatterBoxMessage.h"

@implementation ChatterBoxMessage

- (id) initFromDictionary: (NSDictionary *)dictionary withTimeToken: (NSNumber *)timeToken {
    if(!(self = [super init])) return nil;
    self.content = [dictionary valueForKey:@"content"];
    self.from = [dictionary valueForKey:@"from"];
    self.sentOn = [dictionary valueForKey:@"sentOn"];
    self.type = [dictionary valueForKey:@"type"];
    
    return self;
}

- (NSDictionary *) apnsPayloadForMessage {
    //required pn_apns
    return @{ @"pn_apns" : @{ @"data" : [self asDictionary] }};
}

- (NSDictionary *) asDictionary {
    return @{ @"from": self.from,
              @"content" : self.content,
              @"sentOn" : self.sentOn,
              @"type": self.type };
}

@end
