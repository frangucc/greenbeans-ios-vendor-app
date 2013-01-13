//
//  RootViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "RootViewController.h"
#import "BeanCountViewController.h"
#import "RNBlurModalView.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView * yourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIImage * targetImage = [UIImage imageNamed:@"merchant-background"];
    
    // redraw the image to fit |yourView|'s size
    UIGraphicsBeginImageContextWithOptions(yourView.frame.size, NO, 0.f);
    [targetImage drawInRect:CGRectMake(0.f, 0.f, yourView.frame.size.width, yourView.frame.size.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
    
    UIImageView *logo_view  =[[UIImageView alloc] initWithFrame:CGRectMake(40, 30, 240, 40)];
    [logo_view setImage:[UIImage imageNamed:@"logo-big-white"]];
    [self.view addSubview:logo_view];
    
    UIImageView *mascot_view  =[[UIImageView alloc] initWithFrame:CGRectMake(80, 90, 165, 165)];
    [mascot_view setImage:[UIImage imageNamed:@"bean-mascott"]];
    [self.view addSubview:mascot_view];
    
    UILabel *slots_header_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 263, 300, 30)];
    [slots_header_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
    [slots_header_label setBackgroundColor:[UIColor clearColor]];
    [slots_header_label setTextColor:[UIColor whiteColor]];
    [slots_header_label setText:@"Why give away Green Beans?"];
    [self.view addSubview:slots_header_label];
    
    UIImageView *slot_image_one  =[[UIImageView alloc] initWithFrame:CGRectMake(30, 292, 30, 30)];
    [slot_image_one setImage:[UIImage imageNamed:@"merchant-intro-icon-1"]];
    [self.view addSubview:slot_image_one];
    
    UILabel *slot_label_one = [[UILabel alloc] initWithFrame:CGRectMake(64, 299, 250, 20)];
    [slot_label_one setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_one setBackgroundColor:[UIColor clearColor]];
    [slot_label_one setTextColor:[UIColor whiteColor]];
    [slot_label_one setText:@"Collect customer data in a fun way"];
    [self.view addSubview:slot_label_one];
    
    UIImageView *slot_image_two =[[UIImageView alloc] initWithFrame:CGRectMake(30, 324, 30, 30)];
    [slot_image_two setImage:[UIImage imageNamed:@"merchant-intro-icon-2"]];
    [self.view addSubview:slot_image_two];
    
    UILabel *slot_label_two = [[UILabel alloc] initWithFrame:CGRectMake(64, 330, 250, 20)];
    [slot_label_two setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_two setBackgroundColor:[UIColor clearColor]];
    [slot_label_two setTextColor:[UIColor whiteColor]];
    [slot_label_two setText:@"Reward your best customers"];
    [self.view addSubview:slot_label_two];
    
    UIImageView *slot_image_three =[[UIImageView alloc] initWithFrame:CGRectMake(25, 357, 36, 30)];
    [slot_image_three setImage:[UIImage imageNamed:@"merchant-intro-icon-3"]];
    [self.view addSubview:slot_image_three];
    
    UILabel *slot_label_three = [[UILabel alloc] initWithFrame:CGRectMake(64, 359, 250, 20)];
    [slot_label_three setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [slot_label_three setBackgroundColor:[UIColor clearColor]];
    [slot_label_three setTextColor:[UIColor whiteColor]];
    [slot_label_three setText:@"Get customers to market your business"];
    [self.view addSubview:slot_label_three];
    
    [self drawPrintButton];
}

- (void) drawPrintButton
{
//    // Create and configure button programmatically
//	MOGlassButton* printBeansButton = [[MOGlassButton alloc] initWithFrame:CGRectMake(30, 390, 260, 50)];
//	[printBeansButton setupAsSmallGreenButton];
//    [printBeansButton addTarget:self action:@selector(showProgress) forControlEvents:UIControlEventTouchUpInside];
//	[printBeansButton setTitle:@"Print Beans" forState:UIControlStateNormal];
//	[self.view addSubview:printBeansButton];
    
    UIButton *printBeansButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 404, 260, 44)];
    [printBeansButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
    [printBeansButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
    [printBeansButton addTarget:self action:@selector(showProgress) forControlEvents:UIControlEventTouchUpInside];
    [printBeansButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [printBeansButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [printBeansButton setTitle:@"Initialize Application" forState:UIControlStateNormal];
    printBeansButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];

    [self.view addSubview:printBeansButton];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"green-nav-bar-logo"] forBarMetrics:UIBarMetricsDefault];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showProgress
{    
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	HUD.detailsLabelText = @"searching printers";
	HUD.square = YES;

	[HUD showWhileExecuting:@selector(searchForActiveBluetoothPrinters) onTarget:self withObject:nil animated:YES];
//    
//    BeanCountViewController *bcvc = [[BeanCountViewController alloc] init];
//    [self.navigationController pushViewController:bcvc animated:YES];
}

- (void) searchForActiveBluetoothPrinters
{
    searchView = [[SearchPrinters alloc] init];
    active_connections_availiable = [searchView searchConnections];
    
    BeanCountViewController *bcvc = [[BeanCountViewController alloc] init];
    [self.navigationController pushViewController:bcvc animated:YES];
}

@end
