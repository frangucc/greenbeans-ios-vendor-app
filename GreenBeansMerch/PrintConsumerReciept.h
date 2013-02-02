//
//  CreateTokenFromServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "MiniPrinterFunctions.h"
#import "CachedTokenSets.h"

/*
 CreateTokenFromServer Interface
 --------
 Delegate:        NSObject
 Inheritance:     NSURLConnectionDataDelegate, NSURLConnectionDelegate
 Author:          Neil Burchfield
 */
@interface PrintConsumerReciept : NSObject {

    CachedTokenSets *cachedTokens;
}

- (BOOL) sendOptionsToPrint;

@end
