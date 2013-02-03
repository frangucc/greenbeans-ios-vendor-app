//
//  RootViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "CreateNewUserViewController.h"

/* Definitions */
#define FIT_ERROR_H 20

@implementation CreateNewUserViewController
@synthesize authenticateMerchant = _authenticateMerchant;

/*
   ViewDidLoad
   --------
   Purpose:        This function Instantiates the View
   Parameters:     none
   Returns:        none
   Notes:          Adds View
   Author:         Neil Burchfield
 */
- (void) viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    [self drawLoginButton];
    [self addCustomBackButton];
} /* viewDidLoad */


/*
   AddCustomBackButton
   --------
   Purpose:        Adds Custom Back Button to View
   Parameters:     animated
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) addCustomBackButton {
    UIImageView *flashNavig = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green-nav-bar-logo"]];
    [flashNavig setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    
    UIImage *backImage = [UIImage imageNamed:@"back_btn"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 5, backImage.size.width, backImage.size.height);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popParentViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:flashNavig];
    [self.view addSubview:backButton];

    self.navigationItem.hidesBackButton   = YES;
} /* addCustomBackButton */


/*
   PopParentViewController
   --------
   Purpose:        Pop Parent
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) popParentViewController:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];

} /* popParentViewController */


/*
   DrawView
   --------
   Purpose:        Alloc/Create/Add View ~ No IB/SB
   Parameters:     none
   Returns:        none
   Notes:          Adds View
   Author:         Neil Burchfield
 */
- (void) drawView {
    UIView *windowFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIImage *targetImage = [UIImage imageNamed:@"merchant-background"];

    UIGraphicsBeginImageContextWithOptions(windowFrame.frame.size, NO, 0.f);
    [targetImage drawInRect:CGRectMake(0.f, 0.f, windowFrame.frame.size.width, windowFrame.frame.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
    [self.navigationBar setHidden:YES];

    [self.tableView setFrame:CGRectMake(0, 105, 320, 387)];

    /* Stats Label ~ [CustomUI makeLabel] */
    newAccount = [CustomUI makeLabel:@"Create a New Account" x_value:0 y_value:60 width:320 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.5] text_color:[UIColor whiteColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor grayColor] shadow_off:CGSizeMake(1, 2)];
    [newAccount setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:newAccount];

    errorCurrentlyInView = NO;

} /* drawView */


/*
   DrawLoginButton
   --------
   Purpose:        Draw Login Button
   Parameters:     none
   Returns:        none
   Notes:          Alloc/Create/Add Login Button
   Author:         Neil Burchfield
 */
- (void) drawLoginButton {
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 404, 260, 44)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
//    [loginButton addTarget:self action:@selector(createMBProgressHUDViewForLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"Create Account" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];

    [self.view addSubview:loginButton];
} /* drawLoginButton */


/*
   ViewWillAppear
   --------
   Purpose:        Delegate ~ Set/Hide Navigation Bar
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"green-nav-bar-logo"] forBarMetrics:UIBarMetricsDefault];
} /* viewWillAppear */


/*
   DidReceiveMemoryWarning
   --------
   Purpose:        Buffer Overflow Handler
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
} /* didReceiveMemoryWarning */


/*
   createMBProgressHUDViewForLogin
   --------
   Purpose:        Creates HUD & Authenticates User on another thread
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) createMBProgressHUDViewForLogin {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];

    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.detailsLabelText = @"Logging in...";
    HUD.square = YES;
    [self cacheUsersCredentialsOffline];
    [HUD showWhileExecuting:@selector(launchMainApplication) onTarget:self withObject:nil animated:YES];
} /* createMBProgressHUDViewForLogin */


/*
   DisplayFailedLogin
   --------
   Purpose:        Failed Login Handler
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) displayFailedLogin {
    if (!errorCurrentlyInView) {
        [self.view.layer addAnimation:[self transitionWithDuration:.5f type:kCATransitionMoveIn sub:kCATransitionFade] forKey:nil];

        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x,
                                            self.tableView.frame.origin.y + FIT_ERROR_H,
                                            self.tableView.frame.size.width,
                                            self.tableView.frame.size.height)];

        [newAccount setFrame:CGRectMake(newAccount.frame.origin.x,
                                        newAccount.frame.origin.y + FIT_ERROR_H,
                                        newAccount.frame.size.width,
                                        newAccount.frame.size.height)];

        [createLoginButton setFrame:CGRectMake(createLoginButton.frame.origin.x,
                                               createLoginButton.frame.origin.y + FIT_ERROR_H,
                                               createLoginButton.frame.size.width,
                                               createLoginButton.frame.size.height)];

        [remMeCntl setFrame:CGRectMake(remMeCntl.frame.origin.x,
                                       remMeCntl.frame.origin.y + FIT_ERROR_H,
                                       remMeCntl.frame.size.width,
                                       remMeCntl.frame.size.height)];

        [remMeLabel setFrame:CGRectMake(remMeLabel.frame.origin.x,
                                        remMeLabel.frame.origin.y + FIT_ERROR_H,
                                        remMeLabel.frame.size.width,
                                        remMeLabel.frame.size.height)];

        /* Stats Label ~ [CustomUI makeLabel] */
        error = [CustomUI makeLabel:@"Ouch! Credentials Failed." x_value:0 y_value:127 width:320 height:34 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16] text_color:[UIColor whiteColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor lightGrayColor] shadow_off:CGSizeMake(0, 1)];
        [error setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:error];
        errorCurrentlyInView = YES;
    }
} /* displayFailedLogin */


/*
   TransitionWithDuration
   --------
   Purpose:        General CATransition object
   Parameters:     -- duration
   -- type
   -- subtype
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (CATransition *) transitionWithDuration:(float)duration type:(NSString *)type sub:(NSString *)subtype {

    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = type;
    transition.subtype = subtype;

    return transition;
} /* transitionWithDuration */


/*
   VerifyMerchantLogin
   --------
   Purpose:        Verifies Merchant's Credentials
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (bool) verifyMerchantLogin {
    if (([[loginId text] length] > 0) && ([[password text] length] > 0)) {
//        [AppDelegate setMerchantPassword:[password text]];
//        [AppDelegate setMerchantEmail:[loginId text]];
        return YES;
    } else {
        blurTitle = @"Incorrect Credentials";
        blurMessage = @"Please retry entering your login/password again";
        [self performSelectorOnMainThread:@selector(displayBlurViewMessage) withObject:nil waitUntilDone:NO];
        return NO;
    }
} /* verifyMerchantLogin */


/*
   DisplayBlurViewMessage
   --------
   Purpose:        General Blur Modal Object
   Parameters:     -- title
   -- message
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) displayBlurViewMessage {
    blurModalView = [[RNBlurModalView alloc] initWithViewController:self title:blurTitle message:blurMessage];
    [blurModalView show];
} /* displayBlurViewMessage */


/*
   NumberOfRowsInSection
   --------
   Purpose:        Tableview Delegate
   Parameters:     none
   Returns:        none
   Notes:          Number of Tableview Rows
   Author:         Neil Burchfield
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
} /* tableView */


/*
   CellForRowAtIndexPath
   --------
   Purpose:        Tableview Cell Delegate
   Parameters:     none
   Returns:        none
   Notes:          View for Cell
   Author:         Neil Burchfield
 */
- (UITableViewCell *) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
    if ( cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    if (indexPath.row == 0) {
        name = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        name.placeholder = @"Name";
        name.autocorrectionType = UITextAutocorrectionTypeNo;
        name.returnKeyType = UIReturnKeyNext;
        name.keyboardType = UIKeyboardTypeEmailAddress;
        cell.accessoryView = name;
    }
    if (indexPath.row == 1) {
        loginId = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        loginId.placeholder = @"Email";
        loginId.autocorrectionType = UITextAutocorrectionTypeNo;
        loginId.returnKeyType = UIReturnKeyNext;
        loginId.keyboardType = UIKeyboardTypeEmailAddress;
        cell.accessoryView = loginId;
    }
    if (indexPath.row == 2) {
        company = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        company.placeholder = @"Company";
        company.autocorrectionType = UITextAutocorrectionTypeNo;
        company.returnKeyType = UIReturnKeyNext;
        company.keyboardType = UIKeyboardTypeEmailAddress;
        cell.accessoryView = company;
    }
    if (indexPath.row == 3) {
        password = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.returnKeyType = UIReturnKeyDefault;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        password.autocorrectionType = UITextAutocorrectionTypeNo;
        cell.accessoryView = password;
    }
    loginId.delegate = self;
    password.delegate = self;
    name.delegate = self;
    company.delegate = self;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
} /* tableView */


/*
   textFieldShouldReturn
   --------
   Purpose:        TextField Delegate
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (BOOL) textFieldShouldReturn:(UITextField *)textField {

    if (textField == password) {
        [textField resignFirstResponder];
    }
    else  {
        [password becomeFirstResponder];
    }

    return YES;
} /* textFieldShouldReturn */


/*
   cacheUsersCredentialsOffline
   --------
   Purpose:        Cache User Creds
   Parameters:     none
   Returns:        none
   Notes:          Writes Creds to .plist and
   sets them in KeyChain
   Author:         Neil Burchfield
 */
- (void) cacheUsersCredentialsOffline {
    if (remMeCntl.on) {
        userCreds = [[UserCredentials alloc] init];
        [userCreds writeUsernameAndStateToPlist:loginId.text:YES];
        [userCreds setUsernameIntoKeyChainWithPassword:loginId.text:password.text];
    }
} /* cacheUsersCredentialsOffline */


/*
   NumberOfSectionsInTableView
   --------
   Purpose:        Tableview Sections Delegate
   Parameters:     none
   Returns:        none
   Notes:          Number of sections
   Author:         Neil Burchfield
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
} /* numberOfSectionsInTableView */


@end
