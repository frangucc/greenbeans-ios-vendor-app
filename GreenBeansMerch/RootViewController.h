//
//  RootViewController.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPrinters.h"
#import "MOGlassButton.h"
#import "ReturnSelectedCellText.h"
#import "MBProgressHUD.h"

@interface RootViewController : UIViewController <MBProgressHUDDelegate> {
    
    MBProgressHUD *HUD;
    SearchPrinters *searchView;
    BOOL active_connections_availiable;
}

@end
