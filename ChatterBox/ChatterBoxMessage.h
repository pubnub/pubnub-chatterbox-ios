//
//  ChatterBoxMessage.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/22/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatterBoxMessage : NSObject

@property(nonatomic) NSString *type;
@property(nonatomic) NSString *from;
@property(nonatomic) NSString *content;
@property(nonatomic) NSNumber  *sentOn;


-  (id) initFromDictionary: (NSDictionary *)dictinary withTimeToken: (NSNumber *)timeToken;
-  (NSDictionary *) asDictionary;
-  (NSDictionary *) apnsPayloadForMessage;


@end
