//
//  BeanCountViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "BeanCountViewController.h"
#import "MiniPrinterFunctions.h"
#import "PrinterFunctions.h"
#import "ConnectServer.h"
#import "DisconnectServer.h"
#import "RNBlurModalView.h"

#define TEMP_TITLE @"Administrator"
#define TEMP_BUSINESS_NAME @"Giordanios"
#define TEMP_DISTRIBUTED 39
#define TEMP_CLAIMED 29


@implementation BeanCountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:241.0/255.0 blue:243.0/255.0 alpha:1];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
    self.navigationController.navigationBar.layer.shadowRadius = 3;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.5;
    
    // Custom Back Button
    UIImage *backImage = [UIImage imageNamed:@"back_withText"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 53, 32);
    
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBackButton:)    forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;

    
    UIView *block_header_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 63)];
    [block_header_view setBackgroundColor:[UIColor whiteColor]];
    block_header_view.layer.shadowOffset = CGSizeMake(0, 3);
    block_header_view.layer.shadowRadius = 3;
    block_header_view.layer.shadowOpacity = 0.5;
    
    UIImageView * merchantlogo = [[UIImageView alloc] initWithFrame:CGRectMake(16, 12, 44, 40)];
    merchantlogo.layer.cornerRadius = 5.0;
    merchantlogo.layer.masksToBounds = YES;
    merchantlogo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    merchantlogo.layer.borderWidth = .6;
    [merchantlogo setImage:[UIImage imageNamed:@"merchant-logo-giordanos"]];
    [block_header_view addSubview:merchantlogo];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 200, 40)];
    [title setText:TEMP_TITLE];
    [title setTextColor:[UIColor lightGrayColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName:@"HelveticaNeue" size:8]];
    [block_header_view addSubview:title];
    
    UILabel *business_name = [[UILabel alloc] initWithFrame:CGRectMake(70, 11, 200, 40)];
    [business_name setText:TEMP_BUSINESS_NAME];
    [business_name setTextColor:[UIColor colorWithRed:74.0/255.0 green:168.0/255.0 blue:61.0/255.0 alpha:1]];
    [business_name setBackgroundColor:[UIColor clearColor]];
    [business_name setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:10]];
    [block_header_view addSubview:business_name];
    
    UILabel *stats = [[UILabel alloc] initWithFrame:CGRectMake(70, 22, 200, 40)];
    [stats setText:[NSString stringWithFormat:@"%d Beans Distributed, %d Claimed", TEMP_DISTRIBUTED, TEMP_CLAIMED]];
    [stats setTextColor:[UIColor darkGrayColor]];
    [stats setBackgroundColor:[UIColor clearColor]];
    [stats setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:9]];
    [block_header_view addSubview:stats];
    
    [self.view addSubview:block_header_view];
    
    UIButton *printBeansButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 260, 47)];
    [printBeansButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
    [printBeansButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
    [printBeansButton addTarget:self action:@selector(printAssignedNumberofBeans) forControlEvents:UIControlEventTouchUpInside];
    [printBeansButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [printBeansButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [printBeansButton setTitle:@"Print Beans" forState:UIControlStateNormal];
    printBeansButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    [self.view addSubview:printBeansButton];

    int count = 1;
    int x = 20, y = 185;
    while (count <= 10) {
        
        UIButton *box_button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 48, 48)];
        [box_button setBackgroundImage:[UIImage imageNamed:@"number-print-background-gray"] forState:UIControlStateNormal];
        [box_button setBackgroundImage:[UIImage imageNamed:@"number-print-background-green"] forState:UIControlStateSelected];
        [box_button setTag:count];
        [box_button addTarget:self action:@selector(buttonStateHandler:) forControlEvents:UIControlEventTouchUpInside];
        [box_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [box_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [box_button setTitle:[NSString stringWithFormat:@"%@", [NSNumber numberWithInt:count]] forState:UIControlStateNormal];
        box_button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
        
        [self.view addSubview:box_button];
        
        x += 58;
        if ( count == 5 )
        {
            y = 240;
            x = 20;
        }
        
        count++;
    }
    
    UIImageView * tabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 358, 320, 60)];
    [tabBar setImage:[UIImage imageNamed:@"home_forbeans"]];
    [self.view addSubview:tabBar];
}

- (void) buttonStateHandler:(UIButton *)button {
    for (int x = 1; x <= 10; x++)
    {
        if (x != button.tag)
        {
            UIButton *button = (UIButton *)[self.view viewWithTag:x];
            [button setSelected:NO];
        }
    }
    button.selected = !button.selected;
    selectedButton = button.tag;
    [AppDelegate setQuantity:selectedButton];
}

- (void)printAssignedNumberofBeans
{
    [self retrieveTokenFromServer];
}
- (void) retrieveTokenFromServer
{
    ConnectServer *cs = [[ConnectServer alloc] init];
    [cs activateSessionWithPOST:YES :selectedButton];
}
- (void) displayModalBlur:(NSString *)title :(NSString *)body
{
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:title message:body];
    [modal show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
