//
//  DisconnectServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DisconnectServer : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    
    NSMutableData *responseData;
    
}

- (void) disconnectSessionWithPOST;

@end
