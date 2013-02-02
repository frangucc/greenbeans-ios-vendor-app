//
//  ConnectServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "CacheTokenObjects.h"
#import "AppDelegate.h"

@class ASINetworkQueue;
@class CacheTokenObjects;

/*
 ConnectServer Interface
 --------
 Delegate:        NSObject
 Inheritance:     NSURLConnectionDataDelegate, NSURLConnectionDelegate
 Author:          Neil Burchfield
 */
@interface ConnectServer : NSObject {
    
    ASINetworkQueue *networkQueue;
    NSString *authenticationToken;
	BOOL failed;

}

@property (nonatomic, retain) CacheTokenObjects *cache;

- (void) initilizeConcurrentAPISession;

@end
