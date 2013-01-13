//
//  IOS_SDKViewControllerMobile.h
//  IOS_SDK
//
//  Created by Tzvi on 8/2/11.
//  Copyright 2011 STAR MICRONICS CO., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiniPrinterFunctions.h"
#import "SearchPrinterViewController.h"

@interface IOS_SDKViewControllerMobile : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, ReturnSelectedCellTextDelegate> {
    NSMutableArray *arrayFunction;

    MiniPrinterFunctions *miniPrinterFunctions;
    SearchPrinterViewController *searchView;
    
    IBOutlet UITextField *uitextfield_portname;
    IBOutlet UITableView *tableviewFunction;
    IBOutlet UIButton *buttonBack;

    NSInteger selectIndex;
}

- (IBAction)showHelp;
- (void)SetPortInfo;
- (id)init;

- (IBAction)pushButtonSearch:(id)sender;
- (IBAction)pushButtonBack:(id)sender;

@end
