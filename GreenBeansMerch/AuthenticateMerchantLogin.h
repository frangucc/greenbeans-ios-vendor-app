//
//  AuthenticateMerchantLogin.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/20/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AppDelegate.h"

/*
 AuthenticateMerchantLogin Interface
 --------
 Delegate:        NSObject
 Inheritance:     --
 Author:          Neil Burchfield
 */
@interface AuthenticateMerchantLogin : NSObject {
    
    ASIHTTPRequest *loginRequest;
    NSString *authenticationToken;
    int serverInterationCount;
}

@property (nonatomic) bool loginSuccessful;

- (bool) loginMerchantWithCredentials;

@end

