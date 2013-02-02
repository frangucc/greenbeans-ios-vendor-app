//
//  CacheTokenObjects.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/19/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AppDelegate.h"
#import "CachedTokenSets.h"
#import "ConnectServer.h"

@class ASINetworkQueue;

@interface CacheTokenObjects : NSObject {
    
    ASINetworkQueue *networkQueue;
    NSString *authenticationToken;
    BOOL failed;
}

@property (nonatomic, retain) CachedTokenSets *cache;

- (void) fillApplicationTokenSets;

@end