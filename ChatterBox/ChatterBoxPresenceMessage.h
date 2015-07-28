//
//  ChatterBoxPresenceMessage.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/24/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatterBoxPresenceMessage : NSObject

@property(nonatomic) NSString *type;
@property(nonatomic) NSString *uuid;
@property(nonatomic) NSArray *occupants;



@end
