//
//  RootViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "RootViewController.h"
#import "BeanCountViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1.0f];
    
    insetScroller = [[UIScrollView alloc] init];
    
    CGSize size = CGSizeMake(320, 10);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIImage *img = [UIImage imageNamed:@"gb_top_buffer"];
    [img drawInRect:CGRectMake(0, 0, 320, 10)];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    nav.backgroundColor = [UIColor colorWithPatternImage:newimg];
    [self.navigationController.navigationBar addSubview:nav];
    
    size = CGSizeMake(320, 44);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    img = [UIImage imageNamed:@"gb_nav_low@2x"];
    [img drawInRect:CGRectMake(0, 0, 320, 44)];
    
    newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    nav = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 44)];
    nav.backgroundColor = [UIColor colorWithPatternImage:newimg];
    [self.navigationController.navigationBar addSubview:nav];
    
    /* Tab Image */
    size = CGSizeMake(318, 21);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    img = [UIImage imageNamed:@"gb_tab_info@2x"];
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *navigationBuffer = [[UIView alloc] initWithFrame:CGRectMake(1, 48, size.width, size.height)];
    navigationBuffer.backgroundColor = [UIColor colorWithPatternImage:newimg];
    [self.navigationController.navigationBar addSubview:navigationBuffer];
    
    [self drawPrintButton];
}

- (void) drawPrintButton
{
    // Create and configure button programmatically
	MOGlassButton* printBeansButton = [[MOGlassButton alloc] initWithFrame:CGRectMake(100, 230, 120, 23)];
	[printBeansButton setupAsSmallGreenButton];
    [printBeansButton addTarget:self action:@selector(presentModalBeanCountView) forControlEvents:UIControlEventTouchUpInside];
	[printBeansButton setTitle:@"Print Beans" forState:UIControlStateNormal];
	[self.view addSubview:printBeansButton];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) presentModalBeanCountView
{
    BeanCountViewController *bcvc = [[BeanCountViewController alloc] initWithNibName:@"BeanCountViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:bcvc animated:YES completion:nil];
}


@end
