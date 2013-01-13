//
//  CreateTokenFromServer.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CreateTokenFromServer : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    
    NSMutableData *responseData;
}

- (void) createTokenWithPOST:(int)quantity;

@end
