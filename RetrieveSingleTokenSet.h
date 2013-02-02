//
//  RetrieveSingleToken.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/20/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AppDelegate.h"

@class ASINetworkQueue;

@interface RetrieveSingleTokenSet : NSObject {
    
    ASINetworkQueue *networkQueue;
    NSString *authenticationToken;
    BOOL failed;
}

- (void) refillTokenSet :(int)set;

@end