//
//  UserRegistrationViewController.h
//  ChatterBox
//
//  Created by Frederick Brock on 7/23/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tbFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tbLastName;
@property (weak, nonatomic) IBOutlet UITextField *tbEmailAddresss;
@property (weak, nonatomic) IBOutlet UITextField *tbPassword;
@property (weak, nonatomic) IBOutlet UITextField *tbCompanyName;
@property (weak, nonatomic) IBOutlet UITextField *tbLocation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

- (IBAction)registerNewUser:(id)sender;
@end
