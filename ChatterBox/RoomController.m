//
//  ModelController.m
//  ChatterBox
//
//  Created by Frederick Brock on 6/11/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <PubNub/PubNub.h>

#import "RoomController.h"
#import "ChatViewController.h"
#import "PresenceViewController.h"

#define PRESENCE_PAGE  0
#define CHATVIEW_PAGE  1


@interface RoomController(PNObjectEventListener)
  @property(nonatomic) NSMutableArray *messages;
  @property(nonatomic) NSMutableArray *presenceMessage;

@end





@implementation RoomController



- (instancetype)init {
    self = [super init];
    if (self) {
        self.messages = [[NSMutableArray alloc] init];
        self.presenceMessage = [[NSMutableArray alloc] init];
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    
    NSArray *pages = @[@CHATVIEW_PAGE, @PRESENCE_PAGE];
    if(index > [pages count]){
        return nil;
    }
    
    UIViewController *viewControllforIndex = nil;
    
    switch(index){
        case PRESENCE_PAGE:
            viewControllforIndex = [storyboard instantiateViewControllerWithIdentifier: @"PresenceViewController"];
            break;
        case CHATVIEW_PAGE:
            viewControllforIndex = [storyboard instantiateViewControllerWithIdentifier: @"ChatViewController"];
            break;
        default:
            viewControllforIndex = nil;
            NSLog(@"pageController asked for invalid view controller");
    }

    return viewControllforIndex;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    if([viewController.class isSubclassOfClass:ChatViewController.class]){
        return CHATVIEW_PAGE;
    }else if([viewController.class isSubclassOfClass:PresenceViewController.class]){
        return PRESENCE_PAGE;
    }
    
    return -1;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController: viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController: viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 2) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
