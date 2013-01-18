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

/*
 BeanCountViewController Interface
 --------
 Delegate:        UIViewController
 Inheritance:     MBProgressHUDDelegate
 Author:          Neil Burchfield
 */
@interface BeanCountViewController : UIViewController <MBProgressHUDDelegate> {

    int selectedButton;
    MBProgressHUD *HUD;
}

@end
