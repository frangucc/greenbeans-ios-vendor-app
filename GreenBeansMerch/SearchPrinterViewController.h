//
// BeanCountViewController.h
// GreenBeansMerch
//
// Created by Burchfield, Neil on 1/12/13.
// Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StarIO/SMPort.h"
#import "RNBlurModalView.h"

@interface SearchPrinterViewController : UITableViewController <MBProgressHUDDelegate> {
    
    NSArray *printerArray;
    NSString *lastSelectedPortName;
    RNBlurModalView *blurModalView;
    NSString *blurTitle;
    NSString *blurMessage;
}

@property(readonly) NSString *lastSelectedPortName;

@end
