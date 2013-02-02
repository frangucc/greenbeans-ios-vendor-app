//
// BeanCountViewController.h
// GreenBeansMerch
//
// Created by Burchfield, Neil on 1/12/13.
// Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "MiniPrinterFunctions.h"
#import "PrinterFunctions.h"
#import "DisconnectServer.h"
#import "RNBlurModalView.h"
#import "CustomUI.h"
#import <QuartzCore/QuartzCore.h>
#import "ConnectServer.h"
#import "PrintConsumerReciept.h"
#import "RNBlurModalView.h"
#import "SearchPrinters.h"

@class ConnectServer;

/*
 BeanCountViewController Interface
 --------
 Delegate:        UIViewController
 Inheritance:     MBProgressHUDDelegate
 Author:          Neil Burchfield
 */
@interface BeanCountViewController : UIViewController <MBProgressHUDDelegate> {

    int selectedButton;
    BOOL active_connections_availiable;
    
    NSString *blurTitle;
    NSString *blurMessage;
    UIButton *printButton;
    UIView *block_header_view;
    
    MBProgressHUD *HUD;
    RNBlurModalView *blurModalView;
    SearchPrinters *searchPrinters;
}

@property (nonatomic, retain) ConnectServer *connect;

@end
