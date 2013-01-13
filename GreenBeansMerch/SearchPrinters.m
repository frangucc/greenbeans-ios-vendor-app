//
//  SearchPrinters.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "SearchPrinters.h"
#import "AppDelegate.h"

@implementation SearchPrinters

- (BOOL)searchConnections
{    
    BOOL flag;
    
    printerArray = [[NSMutableArray alloc] initWithArray:[SMPort searchPrinter]];
    
    if ( printerArray.count > 0 )
    {
        PortInfo *portInfo = [printerArray objectAtIndex:0];
        lastSelectedPortName = portInfo.portName;
        [AppDelegate setPortName:lastSelectedPortName];
        flag = TRUE;
        NSLog(@"printer found");
    }
    else
    {
        flag = NO;
        NSLog(@"printer NOT found");
    }
    
    return flag;
}

@end
