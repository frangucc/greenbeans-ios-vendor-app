//
//  RootViewController_iPad.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 2/1/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "LoginViewController_iPad.h"

/*
 RootViewController Interface
 --------
 Delegate:        UIViewController
 Inheritance:     MBProgressHUDDelegate
 Author:          Neil Burchfield
 */
@interface RootViewController_iPad : UIViewController <MBProgressHUDDelegate> {
    
    MBProgressHUD *HUD;
    NSString *blurTitle;
    NSString *blurMessage;
}

@end