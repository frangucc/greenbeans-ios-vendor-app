//
//  DisconnectServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*
   DisconnectServer Interface
   --------
   Delegate:        NSObject
   Inheritance:     NSURLConnectionDataDelegate, NSURLConnectionDelegate
   Author:          Neil Burchfield
 */
@interface DisconnectServer : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {

    NSMutableData *responseData;
}

- (void) disconnectSessionWithPOST;

@end
