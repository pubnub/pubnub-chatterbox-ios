//
//  ChatterBoxService.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/22/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "ChatterBoxService.h"
#import <PubNub/PubNub.h>


@implementation ChatterBoxService

- (void) connectAsUser: (ChatterBoxUserProfile *) profile {
    
    [PNLog enabled:YES];
    self.profile = profile;
    //TODO:...Grab these from the P-List...later the API
    PNConfiguration *pnConfiguration = [PNConfiguration configurationWithPublishKey:@"demo-36" subscribeKey: @"demo-36"];
    pnConfiguration.uuid = profile.profileID;
    //set other parameters here
    pnConfiguration.presenceHeartbeatInterval = 20;
    pnConfiguration.presenceHeartbeatValue = 60;
    //set the configuration
    self.pubnub = [PubNub clientWithConfiguration: pnConfiguration];
    //register your self as a listener of events
    [self.pubnub addListener: self];
    //State flag
    self.initialized = YES;
}


- (void) client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {

    if([self.listeners objectForKey: message.data.actualChannel]){
        NSArray *listenersForChannel = (NSArray *)[self.listeners objectForKey:message.data.actualChannel];
        ChatterBoxMessage *chatterBoxMessage = [[ChatterBoxMessage alloc] initFromDictionary: message.data.message  withTimeToken: message.data.timetoken];
        for (id crl in listenersForChannel) {
            if([crl conformsToProtocol: @protocol(ChatRoomListener)]){
                id<ChatRoomListener> chatRoomListener = (id<ChatRoomListener>)crl;
                [chatRoomListener messageReceived: chatterBoxMessage];
            }
        }
    }

}

- (void) client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    
    if([event.data.presenceEvent isEqualToString: @"join"]){
        NSLog(@"join event received on channel: %@ for uuid: %@", event.data.actualChannel, event.data.presence.uuid);
        [client stateForUUID:event.data.presence.uuid
                   onChannel: event.data.presence.actualChannel
              withCompletion:^(PNChannelClientStateResult *result, PNErrorStatus *status) {
                  NSLog(@"retrieved current state:  %@", result.data.state);
              }];
        
    }else if(([event.data.presenceEvent isEqualToString:@"leave"]) || ([event.data.presenceEvent isEqualToString:@"timeout"] )){
        
    }else if([event.data.presenceEvent isEqualToString:@"state-change"]){
        //assume you have already received the join for this uuid, and now just update the state
        
    }
}

- (void) client:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status {
    if(!status.isError){
        if(status.category == PNConnectedCategory){
            //set the state of the user
            [client setState: [self.profile asDictionary]
                     forUUID: self.profile.profileID
                   onChannel: @"GLOBAL"  withCompletion:^(PNClientStateUpdateStatus *status) {
                                NSLog(@"status");
                   }];
        }else if(status.category == PNReconnectedCategory){
            //Grab History for your channel
            
        }
    }else{
        //TODO: Handle the error with a "ChatServiceConnectionListener"
        NSLog(@"Error %@", status.errorData);
    }
    
}


+ (id) sharedInstance {
    static ChatterBoxService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.listeners = [[NSMutableDictionary alloc] init];
        
    });
    return sharedInstance;
}

- (void) addRoom: (NSString *) nameForRoom {
    [self.pubnub subscribeToChannels: @[nameForRoom] withPresence:YES];
}

- (void) addChatListenerForRoom:(NSString *)roomName withListener:(id)listener {
    NSMutableArray *listenersForRoom = [[NSMutableArray alloc] init];
    if(self.listeners  != nil){
        if(nil != [self.listeners objectForKey: roomName]){
            listenersForRoom = (NSMutableArray *)[self.listeners objectForKey:roomName];
        }else{
            listenersForRoom = [[NSMutableArray alloc] init];
            [self.listeners setObject: listenersForRoom forKey: roomName];
            
        }
    }
    
    //Check to see if the listener already exists
    //assuming none right now
    [listenersForRoom addObject: listener];
    
}

- (void) removeChatListenerForRoom:(NSString *)roomName withListener:(id)listener {
    
    
}

- (void) sendChatMessageToRoom:(NSString *)roomName message:(ChatterBoxMessage *)m withCompletionBlock:(ChatterBoxPublishCompletionBlock)block{
    //TODO implement
    [self.pubnub publish: [m asDictionary]
                toChannel: roomName
       mobilePushPayload: [m apnsPayloadForMessage]
              compressed: NO
          withCompletion:^(PNPublishStatus *status) {
            if(block){
              if(status.isError){
                      block(status.errorData.description, status.data.timetoken);
               }else{
                   block(nil, status.data.timetoken);
               }
            }
          }
    ];
}
         

@end
