//
//  LoginViewController_iPad.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 2/1/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "BeanCountViewController.h"
#import "IncentivesViewController.h"
#import "CreateIncentivesViewController.h"
#import "SettingsViewController.h"
#import "HomeViewController.h"

#import <UIKit/UIKit.h>
#import "SearchPrinters.h"
#import "MBProgressHUD.h"
#import "SampleViewController.h"
#import "CustomUI.h"
#import "RNBlurModalView.h"
#import "AuthenticateMerchantLogin.h"
#import "UserCredentials.h"

@class AuthenticateMerchantLogin;

/*
 LoginViewController Interface
 --------
 Delegate:        MBProgressHUDDelegate
 Subclass:        UIViewController
 Author:          Neil Burchfield
 */
@interface LoginViewController_iPad : UIViewController <MBProgressHUDDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    MBProgressHUD *HUD;
    RNBlurModalView *blurModalView;
    SearchPrinters *searchView;
    UserCredentials *userCreds;
    
    UITextField *loginId;
    UITextField *password;
    UILabel *newAccount;
    UILabel *error;
    UILabel *remMeLabel;
    UIButton *createLoginButton;
    UISwitch* remMeCntl;
    NSString *blurTitle;
    NSString *blurMessage;
    UITableView *credentialsTableView;
    
    bool errorCurrentlyInView;
}

@property (nonatomic, retain) AuthenticateMerchantLogin *authenticateMerchant;

@end
