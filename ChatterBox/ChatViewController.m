//
//  DataViewController.m
//  ChatterBox
//
//  Created by Frederick Brock on 6/11/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "ChatViewController.h"




@interface ChatViewController()

@property(atomic, readonly) NSMutableArray *messages;
@property(atomic, readonly) NSMutableArray *occupants;

@end


@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _messages =  [[NSMutableArray alloc] initWithCapacity:100];
    _occupants = [[NSMutableArray alloc] initWithCapacity: 100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.messages == nil){
            
    }
}


#pragma - Implementation of UIPageControllerDataSource






#pragma -Implementation of ChatRoomListener protocol

- (void) messageReceived:(ChatterBoxMessage *)message {
   [self.messages addObject:message];
}

- (void) userDidEnterRoom:(ChatterBoxPresenceMessage *)message {
   //implement for join
}

- (void) userDidExitRoom:(ChatterBoxMessage *)message {
    //implement for timeout
}




@end
