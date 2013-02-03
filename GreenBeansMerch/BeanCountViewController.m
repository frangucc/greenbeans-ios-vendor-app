//
// BeanCountViewController.h
// GreenBeansMerch
//
// Created by Burchfield, Neil on 1/12/13.
// Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "BeanCountViewController.h"

/* Static Temp Methods */
#define TEMP_TITLE         @"Administrator"
#define TEMP_BUSINESS_NAME @"Giordanios"
#define TEMP_DISTRIBUTED   39
#define TEMP_CLAIMED       29

@implementation BeanCountViewController
@synthesize connect = _connect;

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
    [self addCustomBackButton];
    [self createMBProgressHUDViewForLogin];
    [self instantiateView];
    [self initiateServerConnection];
} /* viewDidLoad */


- (void) initiateServerConnection {
    self.connect = [[ConnectServer alloc] init];
    [self.connect initilizeConcurrentAPISession];
} /* fillTokensInBackground */


/*
   ViewWillAppear
   --------
   Purpose:        This function Instantiates the View prior to loading
   Parameters:     animated
   Returns:        none
   Notes:          Hides Nav Bar
   Author:         Neil Burchfield
 */
- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
} /* viewWillAppear */


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
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 53, 32);
    [backButton setImage:[UIImage imageNamed:@"back_withText"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBackButton:) forControlEvents:UIControlEventTouchUpInside];

    /*UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
       self.navigationItem.leftBarButtonItem = backBarButtonItem; // Hide Nav Back Button Implementation */

    self.navigationItem.hidesBackButton   = YES;
} /* addCustomBackButton */


/*
   PushBackButton
   --------
   Purpose:        Custom Back Button Implementation
   Parameters:     id
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) pushBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
} /* pushBackButton */


/*
   InstantiateView
   --------
   Purpose:        View Labels, Buttons, etc...
   Parameters:     none
   Returns:        none
   Notes:          View Attributes
   Author:         Neil Burchfield
 */
- (void) instantiateView {
    self.navigationController.navigationBarHidden               = NO;
    self.view.backgroundColor                                   = [UIColor colorWithRed:240.0 / 255.0 green:241.0 / 255.0 blue:243.0 / 255.0 alpha:1];
    self.navigationController.navigationBar.layer.shadowOffset  = CGSizeMake(0, 2);
    self.navigationController.navigationBar.layer.shadowRadius  = 3;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.5;

    block_header_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 63)];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [block_header_view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 105)]; }

    [block_header_view setBackgroundColor:[UIColor whiteColor]];
    block_header_view.layer.shadowOffset  = CGSizeMake(0, 3);
    block_header_view.layer.shadowRadius  = 3;
    block_header_view.layer.shadowOpacity = 0.5;

    UIImageView *merchantlogo = [[UIImageView alloc] initWithFrame:CGRectMake(16, 12, 44, 40)];
    merchantlogo.layer.cornerRadius  = 5.0;
    merchantlogo.layer.masksToBounds = YES;
    merchantlogo.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    merchantlogo.layer.borderWidth   = .6;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        { [merchantlogo setFrame:CGRectMake(26, 12, 88, 80)]; merchantlogo.layer.cornerRadius  = 7.0;}
    [merchantlogo setImage:[UIImage imageNamed:@"merchant-logo-giordanos"]];
    [block_header_view addSubview:merchantlogo];

    
    UILabel *title;
    /* Title Label ~ [CustomUI makeLabel] */
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        title = [CustomUI makeLabel:TEMP_TITLE x_value:135 y_value:6 width:400 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f] text_color:[UIColor darkGrayColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    else
    {
        title = [CustomUI makeLabel:TEMP_TITLE x_value:70 y_value:0 width:200 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:8] text_color:[UIColor lightGrayColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    [block_header_view addSubview:title];

    UILabel *business_name;
    /* Business Name Label ~ [CustomUI makeLabel] */
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        business_name = [CustomUI makeLabel:TEMP_BUSINESS_NAME x_value:135 y_value:25 width:400 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f] text_color:[UIColor colorWithRed:74.0 / 255.0 green:168.0 / 255.0 blue:61.0 / 255.0 alpha:1] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    else
    {
        business_name = [CustomUI makeLabel:TEMP_BUSINESS_NAME x_value:70 y_value:11 width:200 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:10] text_color:[UIColor colorWithRed:74.0 / 255.0 green:168.0 / 255.0 blue:61.0 / 255.0 alpha:1] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    [block_header_view addSubview:business_name];

    
    UILabel *stats;
    /* Stats Label ~ [CustomUI makeLabel] */
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        stats = [CustomUI makeLabel:[NSString stringWithFormat:@"%d Beans Distributed, %d Claimed", TEMP_DISTRIBUTED, TEMP_CLAIMED] x_value:135 y_value:43 width:400 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0f] text_color:[UIColor darkGrayColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    else
    {
        stats = [CustomUI makeLabel:[NSString stringWithFormat:@"%d Beans Distributed, %d Claimed", TEMP_DISTRIBUTED, TEMP_CLAIMED] x_value:70 y_value:22 width:200 height:40 back_color:[UIColor clearColor] font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:10] text_color:[UIColor darkGrayColor] linebreakmode:NSLineBreakByWordWrapping shadow_color:[UIColor clearColor] shadow_off:CGSizeMake(0, 0)];
    }
    [block_header_view addSubview:stats];

    /* Label ->+ subview */
    [self.view addSubview:block_header_view];

    /* Print Button ~ Action: printAssignedNumberofBeans */
    [self drawPrintButton];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        /* Add Boxes to view and add attributes, actions, titles */
        int count = 1;
        int x     = 75, y = 250;
        while (count <= 10) {
            /* Box Label ~ [CustomUI makeLabel] */
            UIButton *box_button = [CustomUI makeButton:[NSString stringWithFormat:@"%@", [NSNumber numberWithInt:count]] title_font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22] x_value:x y_value:y width:105 height:105 back_image_normal:[UIImage imageNamed:@"number-print-background-gray"] back_state_normal:UIControlStateNormal back_image_selected:[UIImage imageNamed:@"number-print-background-green"] back_state_selected:UIControlStateSelected tag:count t_color_normal:[UIColor darkGrayColor] t_color_selected:[UIColor whiteColor]];
            [box_button addTarget:self action:@selector(buttonStateHandler:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:box_button];

            x += 128;    /* Add 128px Pixels on x-axis */
            if (count == 5) {
                y = 380; /* Reset 295px on y-axis */
                x = 75; /* Reset 75px on x-axis */
            }
            count++;
        }
    } else {
        /* Add Boxes to view and add attributes, actions, titles */
        int count = 1;
        int x     = 20, y = 185;
        while (count <= 10) {
            /* Box Label ~ [CustomUI makeLabel] */
            UIButton *box_button = [CustomUI makeButton:[NSString stringWithFormat:@"%@", [NSNumber numberWithInt:count]] title_font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22] x_value:x y_value:y width:48 height:48 back_image_normal:[UIImage imageNamed:@"number-print-background-gray"] back_state_normal:UIControlStateNormal back_image_selected:[UIImage imageNamed:@"number-print-background-green"] back_state_selected:UIControlStateSelected tag:count t_color_normal:[UIColor darkGrayColor] t_color_selected:[UIColor whiteColor]];
            [box_button addTarget:self action:@selector(buttonStateHandler:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:box_button];

            x += 58;    /* Add 58 Pixels on x-axis */
            if (count == 5) {
                y = 240; /* Reset 240px on y-axis */
                x = 20; /* Reset 20px on x-axis */
            }
            count++;
        }
    }
} /* instantiateView */


/*
   DrawPrintButton
   --------
   Purpose:        Draws Print Application
   Parameters:     none
   Returns:        none
   Notes:          Alloc/Create/Add Print Button - Based on iPad/iPhone
   Author:         Neil Burchfield
 */
- (void) drawPrintButton {

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        printButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 600, 500, 66)];
        [printButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background"] forState:UIControlStateNormal];
        [printButton setBackgroundImage:[UIImage imageNamed:@"gray-action-button-background-pressed"] forState:UIControlStateHighlighted];
        [printButton addTarget:self action:@selector(printAssignedNumberofBeans) forControlEvents:UIControlEventTouchUpInside];
        [printButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [printButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [printButton setTitle:@"Print Beans" forState:UIControlStateNormal];
        [printButton setEnabled:NO];
        printButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:26];
    } else {
        printButton = [CustomUI makeButton:@"Print Beans" title_font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]
                                   x_value:30 y_value:100 width:260 height:47 back_image_normal:[UIImage imageNamed:@"gray-action-button-background"]
                         back_state_normal:UIControlStateNormal back_image_selected:[UIImage imageNamed:@"gray-action-button-background-pressed"] back_state_selected:UIControlStateHighlighted tag:-1 t_color_normal:[UIColor darkGrayColor] t_color_selected:[UIColor whiteColor]];
        [printButton addTarget:self action:@selector(printAssignedNumberofBeans) forControlEvents:UIControlEventTouchUpInside];
        /* printAssignedNumberofBeans ->+ subview */
    }
    [self.view addSubview:printButton];
} /* drawInitButton */


/*
   ButtonStateHandler
   --------
   Purpose:        Handles Button Targets, State, etc.
   Parameters:     Button
   Returns:        none
   Notes:          Custom Button Handler
   Author:         Neil Burchfield
 */
- (void) buttonStateHandler:(UIButton *)button {
    for (int x = 1; x <= 10; x++) {
        if (x != button.tag) {
            UIButton *button = (UIButton *)[self.view viewWithTag:x];
            [button setSelected:NO];
        }
    }
    button.selected = !button.selected;

    if (button.selected)
        [printButton setEnabled:YES];
    else
        [printButton setEnabled:NO];

    selectedButton  = button.tag;
    [AppDelegate setQuantity:selectedButton];
} /* buttonStateHandler */


- (void) createMBProgressHUDViewForLogin {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];

    HUD.delegate = self;
    HUD.labelText = @"Searching";
    HUD.detailsLabelText = @"Looking for printers...";
    HUD.square = YES;

    [HUD showWhileExecuting:@selector(searchForActiveBluetoothPrinters) onTarget:self withObject:nil animated:YES];
} /* createMBProgressHUDViewForLogin */


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
    searchPrinters = [[SearchPrinters alloc] init];
    active_connections_availiable = [searchPrinters searchConnections];

    if (!active_connections_availiable) {
        blurTitle = @"No Printers Availiable";
        blurMessage = @"Please re-connect printer and try again";
        [self performSelectorOnMainThread:@selector(displayBlurViewMessage) withObject:nil waitUntilDone:NO];
    }

} /* searchForActiveBluetoothPrinters */


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
   PrintAssignedNumberofBeans
   --------
   Purpose:        Creates HUD for Printing
   Parameters:     none
   Returns:        none
   Notes:          Call retrieveTokenFromServer()
   Author:         Neil Burchfield
 */
- (void) printAssignedNumberofBeans {

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];

    HUD.delegate = self;
    HUD.labelText = @"Printing Beans";
    HUD.detailsLabelText = @"";
    HUD.square = YES;

    [HUD showWhileExecuting:@selector(printRecieptSelector) onTarget:self withObject:nil animated:YES];
} /* retrieveTokenFromServer */


/*
   PrintAssignedNumberofBeans
   --------
   Purpose:        Selector for printAssignedNumberofBeans
   Parameters:     none
   Returns:        none
   Notes:          Allocs PrintConsumerReciept to print reciept
   Author:         Neil Burchfield
 */
- (void) printRecieptSelector {
    PrintConsumerReciept *printReciept = [[PrintConsumerReciept alloc] init];
    BOOL printed = [printReciept sendOptionsToPrint];

    if (!printed) {
        blurTitle = @"Unable To Print";
        blurMessage = @"Please re-connect printer and try again";
        [self performSelectorOnMainThread:@selector(displayBlurViewMessage) withObject:nil waitUntilDone:NO];
    }
} /* printRecieptSelector */


/*
   DisplayModalBlur
   --------
   Purpose:        -- title ~ String
                   -- body ~ String
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) displayModalBlur:(NSString *)title:(NSString *)body {
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:title message:body];
    [modal show];
} /* displayModalBlur */


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


@end