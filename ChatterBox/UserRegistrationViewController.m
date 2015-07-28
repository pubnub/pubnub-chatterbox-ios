//
//  UserRegistrationViewController.m
//  ChatterBox
//
//  Created by Frederick Brock on 7/23/15.
//  Copyright (c) 2015 Frederick Brock. All rights reserved.
//

#import "UserRegistrationViewController.h"
#import "ServiceManager.h"
#import "ProfileService.h"
#import "ChatterBoxUserProfile.h"

#import "LoginViewController.h"


@interface UserRegistrationViewController ()
    @property(atomic) ChatterBoxUserProfile *profile;
    @property(atomic) BOOL isError;
@end


@implementation UserRegistrationViewController


- (void) viewWillAppear:(BOOL)animated {
    
    self.tbEmailAddresss.text = @"";
    self.tbPassword.text = @"";
    self.tbCompanyName.text = @"";
    self.tbFirstName.text = @"";
    self.tbLastName.text = @"";
    self.tbLocation.text = @"";
    self.isError = false;
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"preparing for segue");
    //going back to Login...pass the login details.
    LoginViewController *loginViewController = (LoginViewController *)segue.destinationViewController;
    loginViewController.txtUserName.text = self.profile.email;
    loginViewController.txtPassword.text = self.profile.password;
}


- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.isError;
}

- (IBAction)registerNewUser:(id)sender {
    NSLog(@"entering registerNewUser");
    
    if([self.tbEmailAddresss.text isEqualToString:@""]){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                             message: @"Please supply a valid email address"
                                                            delegate:nil
                                                   cancelButtonTitle: @"Ok"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }
    
    NSString *userName  = self.tbEmailAddresss.text;
    NSString *password  = self.tbPassword.text;
    NSString *company   = self.tbCompanyName.text;
    NSString *firstName = self.tbFirstName.text;
    NSString *lastName  = self.tbLastName.text;
    NSString *location = self.tbLocation.text;
    
    self.isError = (([userName  isEqualToString: @""]) ||
                    ([password  isEqualToString: @""]) ||
                    ([company   isEqualToString: @""]) ||
                    ([firstName isEqualToString: @""]) ||
                    ([lastName  isEqualToString: @""]) ||
                    ([location  isEqualToString: @""]));
                
    
    
    //Validate the data above

    [self.activityIndicator startAnimating];
    ServiceManager *serviceManager = [ServiceManager sharedInstance];
    ProfileService *profileService = [serviceManager profileService];
    
    //New Profile.
    ChatterBoxUserProfile *newProfile = [[ChatterBoxUserProfile alloc]init];
    newProfile.email     = userName;
    newProfile.password   = password;
    newProfile.company    = company;
    newProfile.firstName = firstName;
    newProfile.lastName  = lastName;
    newProfile.location = location;
    
    
    [profileService addProfile: newProfile withCompletionBlock:^(NSError *error, ChatterBoxUserProfile *profile) {
                     NSLog(@"register call is complete");
                     [self.activityIndicator stopAnimating];
             
                     if(error){
                         UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle: @"Could Not Register You you in"
                                                                              message: @"Please supply a valid username/password"
                                                                             delegate:nil
                                                                    cancelButtonTitle: @"Ok"
                                                                    otherButtonTitles:nil];
                         [errorAlert show];
                         
                     }else{
                         NSLog(@"Registered new user: %@",profile);
                         //Segue
                         
                     }
                     
    }];

}






@end
