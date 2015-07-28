//
//  DataViewController.h
//  ChatterBox
//
//  Created by Frederick Brock on 6/11/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatterBoxService.h"
#import "ChatterBoxPresenceMessage.h"
#import "ChatterBoxMessage.h"
#import "ServiceManager.h"

@interface ChatViewController : UIViewController<ChatRoomListener,UIPageViewControllerDataSource>

@property (strong, nonatomic) IBOutlet UILabel *lblRoomName;
@property (strong, nonatomic) IBOutlet UILabel *lblOccupancy;

@end

