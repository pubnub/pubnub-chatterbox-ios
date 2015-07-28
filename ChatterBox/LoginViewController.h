//
//  LoginViewController.h
//  ChatterBox
//
//  Created by Frederick Brock on 6/30/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorLoggingIn;

- (IBAction)btnLoginClick:(id)sender;


@end



