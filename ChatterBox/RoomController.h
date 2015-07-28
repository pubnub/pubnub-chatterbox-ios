//
//  RoomController.h
//  ChatterBox
//
//  Created by Frederick Brock on 6/11/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatViewController;

@interface RoomController : NSObject <UIPageViewControllerDataSource>

@property(nonatomic) NSMutableArray *messages;
@property(nonatomic) NSMutableArray *presenceMessage;

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;




@end

