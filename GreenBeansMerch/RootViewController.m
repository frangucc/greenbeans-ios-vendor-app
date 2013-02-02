//
//  RootViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "RootViewController.h"

@implementation RootViewController

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
    [self drawInitButton];
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

    UIImageView *logo_view = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30, 240, 40)];
    [logo_view setImage:[UIImage imageNamed:@"logo-big-white"]];
    [self.view addSubview:logo_view];

    UIImageView *mascot_view = [[UIImageView alloc] initWithFrame:CGRectMake(80, 90, 165, 165)];
    [mascot_view setImage:[UIImage imageNamed:@"bean-mascott"]];
    [self.view addSubview:mascot_view];

    UILabel *slots_header_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, 320, 30)];
    [slots_header_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
    [slots_header_label setBackgroundColor:[UIColor clearColor]];
    [slots_header_label setTextAlignment:NSTextAlignmentCenter];
    [slots_header_label setTextColor:[UIColor whiteColor]];
    [slots_header_label setText:@"Why give away Green Beans?"];
    [self.view addSubview:slots_header_label];

    UIImageView *slot_image_one = [[UIImageView alloc] initWithFrame:CGRectMake(30, 292, 30, 30)];
    [slot_image_one setImage:[UIImage imageNamed:@"merchant-intro-icon-1"]];
    [self.view addSubview:slot_image_one];

    UILabel *slot_label_one = [[UILabel alloc] initWithFrame:CGRectMake(64, 299, 250, 20)];
    [slot_label_one setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_one setBackgroundColor:[UIColor clearColor]];
    [slot_label_one setTextColor:[UIColor whiteColor]];
    [slot_label_one setText:@"Collect customer data in a fun way"];
    [self.view addSubview:slot_label_one];

    UIImageView *slot_image_two = [[UIImageView alloc] initWithFrame:CGRectMake(30, 324, 30, 30)];
    [slot_image_two setImage:[UIImage imageNamed:@"merchant-intro-icon-2"]];
    [self.view addSubview:slot_image_two];

    UILabel *slot_label_two = [[UILabel alloc] initWithFrame:CGRectMake(64, 330, 250, 20)];
    [slot_label_two setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_two setBackgroundColor:[UIColor clearColor]];
    [slot_label_two setTextColor:[UIColor whiteColor]];
    [slot_label_two setText:@"Reward your best customers"];
    [self.view addSubview:slot_label_two];

    UIImageView *slot_image_three = [[UIImageView alloc] initWithFrame:CGRectMake(25, 357, 36, 30)];
    [slot_image_three setImage:[UIImage imageNamed:@"merchant-intro-icon-3"]];
    [self.view addSubview:slot_image_three];

    UILabel *slot_label_three = [[UILabel alloc] initWithFrame:CGRectMake(64, 359, 250, 20)];
    [slot_label_three setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_three setBackgroundColor:[UIColor clearColor]];
    [slot_label_three setTextColor:[UIColor whiteColor]];
    [slot_label_three setText:@"Get customers to market your business"];
    [self.view addSubview:slot_label_three];
} /* drawView */


/*
   DrawInitButton
   --------
   Purpose:        Init Application
   Parameters:     none
   Returns:        none
   Notes:          Alloc/Create/Add Init Button - Checks Bluetooth Printer
   Author:         Neil Burchfield
 */
- (void) drawInitButton {
    UIButton *initButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 404, 260, 44)];
    [initButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
    [initButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
    [initButton addTarget:self action:@selector(directConsumerToLogin) forControlEvents:UIControlEventTouchUpInside];
    [initButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [initButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [initButton setTitle:@"Initialize Application" forState:UIControlStateNormal];
    initButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];

    [self.view addSubview:initButton];
} /* drawInitButton */


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
   DirectConsumerToLogin
   --------
   Purpose:        Alloc/Create/Add Progress HUD
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) directConsumerToLogin {
    if ([AppDelegate getNetworkAvailibility]) {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];

        HUD.delegate = self;
        HUD.labelText = @"Loading";
        HUD.detailsLabelText = @"Logging in...";
        HUD.square = YES;

        [HUD showWhileExecuting:@selector(pushLoginViewController) onTarget:self withObject:nil animated:YES];
    }
    else
    {
        blurTitle = @"Network Connection Required";
        blurMessage = @"Please go to Settings and connect to a 3G/Wireless network";
        [self displayBlurViewMessage];
    }
} /* directConsumerToLogin */

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
    RNBlurModalView *blurModalView = [[RNBlurModalView alloc] initWithViewController:self title:blurTitle message:blurMessage];
    [blurModalView show];
} /* displayBlurViewMessage */

/*
   PushLoginViewController
   --------
   Purpose:        SearchViewPrinter Instantiation
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) pushLoginViewController {
//    SettingsViewController *lvc = [[SettingsViewController alloc] init];
//    [self.navigationController pushViewController:lvc animated:YES];
    LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"Sample" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:lvc animated:YES];
} /* pushLoginViewController */

@end
