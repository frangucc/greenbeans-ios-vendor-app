//
//  RootViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "LoginViewController.h"

/* Definitions */
#define FIT_ERROR_H 20

@implementation LoginViewController
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
    [self drawCreateLoginButton];
    [self drawRememberLoginControl];
} /* viewDidLoad */


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
    [self.tableView setFrame:CGRectMake(0, 135, 320, 387)];

    UIImageView *logo_view = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30, 240, 40)];
    [logo_view setImage:[UIImage imageNamed:@"logo-big-white"]];
    [self.view addSubview:logo_view];

    UIButton *fbButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 90, 210, 34)];
    [fbButton setBackgroundImage:[UIImage imageNamed:@"fb_connect"] forState:UIControlStateNormal];
    [fbButton.layer setCornerRadius:4.0f];
    [fbButton.layer setShadowColor:[UIColor grayColor].CGColor];
    [fbButton.layer setShadowOffset:CGSizeMake(0, 0)];
    [fbButton.layer setShadowOpacity:1.0f];
    [fbButton.layer setShadowRadius:1.0f];
    [fbButton.layer setMasksToBounds:YES];
    [self.view addSubview:fbButton];

    /* Stats Label ~ [CustomUI makeLabel] */
    newAccount = [CustomUI makeLabel:@"Don't have an account yet?" x_value:0 y_value:270 width:320 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16] text_color:[UIColor whiteColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor lightGrayColor] shadow_off:CGSizeMake(0, 1)];
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
    [loginButton addTarget:self action:@selector(createMBProgressHUDViewForLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];

    [self.view addSubview:loginButton];
} /* drawLoginButton */


/*
   DrawRememberLoginControl
   --------
   Purpose:        Draws Remember Me Switch
   Parameters:     none
   Returns:        none
   Notes:          Alloc/Create/Add Create Remember Button/Label
   Author:         Neil Burchfield
 */
- (void) drawRememberLoginControl {
    /* Remember Label ~ [CustomUI makeLabel] */
    remMeLabel = [CustomUI makeLabel:@"Remember Me?" x_value:15 y_value:246 width:135 height:20 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17.5f] text_color:[UIColor whiteColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor lightGrayColor] shadow_off:CGSizeMake(0, 1)];

    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:106.0 / 255 green:199.0 / 255 blue:80.0 / 255 alpha:1.0]]; // 124	221	97
    [[UISwitch appearance] setTintColor:[UIColor colorWithRed:124.0 / 255 green:221.0 / 255 blue:97.0 / 255 alpha:1.0]]; // 72	178	97
    [[UISwitch appearance] setThumbTintColor:[UIColor colorWithRed:65.0 / 255 green:152.0 / 255 blue:41.0 / 255 alpha:1.0]]; // 65	152	41

    remMeCntl = [[UISwitch alloc] initWithFrame:CGRectMake(233, 240, 58, 19)];
    if ([AppDelegate getRememberMeState])
        [remMeCntl setOn:YES animated:YES];
    else
        [remMeCntl setOn:NO animated:NO];

    [self.view addSubview:remMeCntl];
    [self.view addSubview:remMeLabel];
} /* drawRememberLoginControl */


/*
   DrawCreateLoginButton
   --------
   Purpose:        Draw Create Login Button
   Parameters:     none
   Returns:        none
   Notes:          Alloc/Create/Add Create Login Button
   Author:         Neil Burchfield
 */
- (void) drawCreateLoginButton {
    createLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 320, 200, 35)];
    [createLoginButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
    [createLoginButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
    [createLoginButton addTarget:self action:@selector(createNewUserView:) forControlEvents:UIControlEventTouchUpInside];
    [createLoginButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [createLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [createLoginButton setTitle:@"Create Account" forState:UIControlStateNormal];
    createLoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.5];

    [self.view addSubview:createLoginButton];
} /* drawCreateLoginButton */

- (void)createNewUserView:(id)sender
{
    CreateNewUserViewController *cnuvc = [[CreateNewUserViewController alloc] initWithNibName:@"Sample" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:cnuvc animated:YES];
}
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
    self.navigationController.navigationBarHidden = YES;
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
   LaunchMainApplication
   --------
   Purpose:        Validate User Credentials
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) launchMainApplication {

    self.authenticateMerchant = [[AuthenticateMerchantLogin alloc] init];

    if ([self verifyMerchantLogin]) {
        if ([self.authenticateMerchant loginMerchantWithCredentials]) {
            NSLog(@"Credentials Successfull!!!");
            [self createTabBar];
        } else {
            NSLog(@"Credentials UNSUCCESSFUL!!!");
            [self displayFailedLogin];
        }
    }
} /* showProgress */


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
        [AppDelegate setMerchantPassword:[password text]];
        [AppDelegate setMerchantEmail:[loginId text]];
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
   CreateTabBar
   --------
   Purpose:        Delegate ~ Alloc/Create TabBarController
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) createTabBar {
    UITabBarController *tabbar = [[UITabBarController alloc] init];

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*    Alloc and Instantiate Home navigation controller */
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeTab = [[UINavigationController alloc] initWithRootViewController:home];

    /*    Alloc and Instantiate CreateIncentives navigation controller */
    CreateIncentivesViewController *nestedNav = [[CreateIncentivesViewController alloc] init];
    UINavigationController *createTab = [[UINavigationController alloc] initWithRootViewController:nestedNav];

    /*    Alloc and Instantiate BeansPrinting navigation controller */
    BeanCountViewController *beanPrint = [[BeanCountViewController alloc] init];
    UINavigationController *beanTab = [[UINavigationController alloc] initWithRootViewController:beanPrint];

    /*    Alloc and Instantiate Incentives navigation controller */
    IncentivesViewController *viewIncentives = [[IncentivesViewController alloc] init];
    UINavigationController *incentTab = [[UINavigationController alloc] initWithRootViewController:viewIncentives];

    /*    Alloc and Instantiate Settings navigation controller */
    SettingsViewController *settings = [[SettingsViewController alloc] init];
    UINavigationController *settingsTab = [[UINavigationController alloc] initWithRootViewController:settings];

    tabbar.viewControllers = [NSArray arrayWithObjects:homeTab, createTab, beanTab, incentTab, settingsTab, nil];
    [[tabbar.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[tabbar.tabBar.items objectAtIndex:1] setTitle:@"View"];
    [[tabbar.tabBar.items objectAtIndex:2] setTitle:@""];
    [[tabbar.tabBar.items objectAtIndex:3] setTitle:@"Create"];
    [[tabbar.tabBar.items objectAtIndex:4] setTitle:@"Settings"];

    [[tabbar.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"icon1"]];
    [[tabbar.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"icon2"]];
    [[tabbar.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@""]];
    [[tabbar.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"icon3"]];
    [[tabbar.tabBar.items objectAtIndex:4] setImage:[UIImage imageNamed:@"icon4"]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.5f], UITextAttributeFont, nil]
                                             forState:UIControlStateHighlighted];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor lightTextColor], UITextAttributeTextColor,
                                                       [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.5f], UITextAttributeFont, nil]
                                             forState:UIControlStateNormal];

    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:204.0f/255.0f green:102.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:255.0f / 255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg_center"]];
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];

    [tabbar setSelectedIndex:tabbar.viewControllers.count % 2 + 1];

    window.rootViewController = tabbar;
    [self.navigationController pushViewController:tabbar animated:YES];
} /* createTabBar */


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
    return 2;
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
        loginId = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        loginId.placeholder = @"Login";
        loginId.autocorrectionType = UITextAutocorrectionTypeNo;
        loginId.returnKeyType = UIReturnKeyNext;
        loginId.keyboardType = UIKeyboardTypeEmailAddress;
        if ([AppDelegate getRememberMeState])
            loginId.text = [AppDelegate getMerchantEmail];
        else
            loginId.text = @"";
        [loginId setClearButtonMode:UITextFieldViewModeAlways];
        cell.accessoryView = loginId;
    }
    if (indexPath.row == 1) {
        password = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.returnKeyType = UIReturnKeyDefault;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        password.autocorrectionType = UITextAutocorrectionTypeNo;
        if ([AppDelegate getRememberMeState])
            password.text = [AppDelegate getMerchantPassword];
        else
            password.text = @"";
        [password setClearButtonMode:UITextFieldViewModeAlways];
        cell.accessoryView = password;
    }
    loginId.delegate = self;
    password.delegate = self;

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

    if (textField == loginId) {
        [password becomeFirstResponder];
    } else if (textField == password) {
        [textField resignFirstResponder];
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
