//
//  ChatterBoxService.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/22/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

#include "ChatterBoxMessage.h"
#include "ChatterBoxUserProfile.h"


@protocol ChatRoomListener <NSObject>

    - (void) messageReceived: (ChatterBoxMessage *)message;
    - (void) userDidEnterRoom: (ChatterBoxMessage *)message;
    - (void) userDidExitRoom: (ChatterBoxMessage *)message;
@end

@protocol ChatterBoxConnectionListener <NSObject>

    - (void) didBecomeDisconnected: (NSString *)error;
    - (void) errorHandler: (NSString *)errorStr;
@end

typedef void (^ChatterBoxPublishCompletionBlock)(NSString *err, NSNumber *timeToken);

@interface ChatterBoxService : NSObject <PNObjectEventListener>

    @property(nonatomic,weak) PubNub *pubnub;
    @property(nonatomic,weak) PNConfiguration *pnConfiguration;
    @property(nonatomic,weak) NSString *userID;
    @property(nonatomic) ChatterBoxUserProfile *profile;
    @property NSMutableDictionary *listeners;
    @property(atomic, getter=isConnected) BOOL initialized;


    + (id) sharedInstance;


    - (void) connectAsUser: (ChatterBoxUserProfile *)profile;
    - (void) addChatListenerForRoom: (NSString *)roomName withListener: (id) listener;
    - (void) removeChatListenerForRoom: (NSString *)roomName withListener: (id)listener;
    - (void) sendChatMessageToRoom: (NSString *)roomName message: (ChatterBoxMessage *)m withCompletionBlock: (ChatterBoxPublishCompletionBlock)block;

@end
