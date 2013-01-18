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

    UILabel *slots_header_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 263, 300, 30)];
    [slots_header_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
    [slots_header_label setBackgroundColor:[UIColor clearColor]];
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
    [initButton addTarget:self action:@selector(showProgress) forControlEvents:UIControlEventTouchUpInside];
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
   ShowProgress
   --------
   Purpose:        Alloc/Create/Add Progress HUD - Search BlueTooth
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) showProgress {
    bool test = NO;

    if (test) {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];

        HUD.delegate = self;
        HUD.labelText = @"Loading";
        HUD.detailsLabelText = @"searching printers";
        HUD.square = YES;

        [HUD showWhileExecuting:@selector(searchForActiveBluetoothPrinters) onTarget:self withObject:nil animated:YES];
    }
    [self createTabBar];
} /* showProgress */


/*
   SearchForActiveBluetoothPrinters
   --------
   Purpose:        SearchViewPrinter Instantiation
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) searchForActiveBluetoothPrinters {
    searchView = [[SearchPrinters alloc] init];
    active_connections_availiable = [searchView searchConnections];
} /* searchForActiveBluetoothPrinters */


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
    UIViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeTab = [[UINavigationController alloc] initWithRootViewController:home];

    /*    Alloc and Instantiate CreateIncentives navigation controller */
    UIViewController *create = [[CreateIncentivesViewController alloc] init];
    UINavigationController *createTab = [[UINavigationController alloc] initWithRootViewController:create];

    /*    Alloc and Instantiate BeansPrinting navigation controller */
    UIViewController *beanPrint = [[BeanCountViewController alloc] init];
    UINavigationController *beanTab = [[UINavigationController alloc] initWithRootViewController:beanPrint];

    /*    Alloc and Instantiate Incentives navigation controller */
    UIViewController *viewIncentives = [[IncentivesViewController alloc] init];
    UINavigationController *incentTab = [[UINavigationController alloc] initWithRootViewController:viewIncentives];

    /*    Alloc and Instantiate Settings navigation controller */
    UIViewController *settings = [[SettingsViewController alloc] init];
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
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor grayColor]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg_center"]];

    [tabbar setSelectedIndex:tabbar.viewControllers.count % 2 + 1];

    window.rootViewController = tabbar;
    [self.navigationController pushViewController:tabbar animated:YES];
} /* createTabBar */


@end
