//
//  SearchPrinters.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "SearchPrinters.h"
#import "AppDelegate.h"

/*
   SearchPrinters Implementation
   --------
   Author:          Neil Burchfield
 */
@implementation SearchPrinters

/*
   SearchConnections
   --------
   Purpose:        Search for active Bluetooth Printers
   Parameters:     none
   Returns:        none
   Notes:          Return Boolean
   Author:         Neil Burchfield
 */
- (bool) searchConnections {
    bool flag;

    printerArray = [[NSMutableArray alloc] initWithArray:[SMPort searchPrinter]];

    if ( printerArray.count > 0 ) {
        PortInfo *portInfo = [printerArray objectAtIndex:0];
        lastSelectedPortName = portInfo.portName;
        [AppDelegate setPortName:lastSelectedPortName];
        flag = TRUE;
        NSLog(@"Printer --> Found");
    } else {
        flag = NO;
        NSLog(@"Printer --> NOT Found");
    }

    return flag;
} /* searchConnections */


@end
