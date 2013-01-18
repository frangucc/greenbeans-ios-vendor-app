//
//  RootViewController.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "BeanCountViewController.h"
#import "IncentivesViewController.h"
#import "CreateIncentivesViewController.h"
#import "SettingsViewController.h"
#import "HomeViewController.h"
#import <UIKit/UIKit.h>
#import "SearchPrinters.h"
#import "MBProgressHUD.h"

/*
   RootViewController Interface
   --------
   Delegate:        UIViewController
   Inheritance:     MBProgressHUDDelegate
   Author:          Neil Burchfield
 */
@interface RootViewController : UIViewController <MBProgressHUDDelegate> {

    MBProgressHUD *HUD;
    SearchPrinters *searchView;
    BOOL active_connections_availiable;
}

@end
