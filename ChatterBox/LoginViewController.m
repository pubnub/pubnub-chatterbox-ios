//
//  LoginViewController.m
//  ChatterBox
//
//  Created by Frederick Brock on 6/30/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileService.h"
#import "ServiceManager.h"

@implementation LoginViewController

- (void) viewWillAppear:(BOOL)animated {
    self.activityIndicatorLoggingIn.hidesWhenStopped = YES;
    [self.activityIndicatorLoggingIn stopAnimating ];
}

- (IBAction)btnLoginClick:(id)sender {
    NSLog(@"attempting to login a user");
   
    if([self.txtUserName.text isEqualToString:@""]){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                            message: @"Please supply a username"
                                                            delegate:nil
                                                    cancelButtonTitle: @"Ok"
                                                        otherButtonTitles:nil];
        [errorAlert show];
        
    }

    NSString *userName = self.txtUserName.text;
    NSString *password = self.txtPassword.text;
    
    //Authenticate the user, and then initialize the ChatterBoxService for this user
    [self.activityIndicatorLoggingIn startAnimating];
    ProfileService *profileService = [ProfileService sharedInstance];
    [profileService authenticateUser: userName
                            password: password
                 withCompletionBlock:^(NSError *error, ChatterBoxUserProfile *profile) {
                     NSLog(@"authentication call is complete");
                     [self.activityIndicatorLoggingIn stopAnimating];
                     //error handling
                     if(error){
                         UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle: @"Could Not Log you in"
                                                                              message: @"Please supply a valid username/password"
                                                                             delegate:nil
                                                                    cancelButtonTitle: @"Ok"
                                                                    otherButtonTitles:nil];
                         [errorAlert show];
 
                     }else{
                         ChatterBoxService *chatterBoxService = [ServiceManager sharedInstance];
                         //Connecting as User.
                         [chatterBoxService connectAsUser:profile];
                         [self performSegueWithIdentifier:@"loginUser" sender:self];
                     }
                   
                 }
     ];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        NSLog(@"prepare for segue ss %@ ", segue);
}

@end

