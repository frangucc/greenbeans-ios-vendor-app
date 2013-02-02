//
//  SettingsViewController.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/17/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleViewController.h"
#import "AppDelegate.h"
#import "SearchPrinterViewController.h"
#import "AboutViewController.h"

@interface SettingsViewController : UIViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    
    UITableView *settingsTableView;
    AboutViewController *avc;
    int viewCount;
}

- (void) segmentedControlChangedValue:(SVSegmentedControl *)cntl;

@end
