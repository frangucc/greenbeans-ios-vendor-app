//
//  ConnectServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*
 ConnectServer Interface
 --------
 Delegate:        NSObject
 Inheritance:     NSURLConnectionDataDelegate, NSURLConnectionDelegate
 Author:          Neil Burchfield
 */
@interface ConnectServer : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {

    NSMutableData *responseData;
    bool createToken;
}

- (void) activateSessionWithPOST :(bool)create :(int)quantity;

@end
