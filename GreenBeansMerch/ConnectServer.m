//
//  ConnectServer.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "ConnectServer.h"

#define TEST_EMAIL   @"fran@greenbean.com"
#define TEST_PASS    @"password"
#define SESSIONS_URL @"http://greenbean.herokuapp.com/api/sessions.json"

// Private stuff
@interface ConnectServer ()
- (void) fetchAuthTokenFailed:(ASIHTTPRequest *)request;
- (void) fetchAuthTokenComplete:(ASIHTTPRequest *)request;
@end

@implementation ConnectServer
@synthesize cache = _cache;

/*
   InitVars
   --------
   Purpose:        Init Email/Password Setters in Delegate Class
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) initVars {
    [AppDelegate setMerchantPassword:TEST_PASS];
    [AppDelegate setMerchantEmail:TEST_EMAIL];
} /* initVars */


/*
   InitilizeConcurrentAPISession
   --------
   Purpose:        Initilizes ROR API Session
   Parameters:     none
   Returns:        none
   Notes:          Sets Authentication Token for Entire Session
   Author:         Neil Burchfield
 */
- (void) initilizeConcurrentAPISession {

    [self initVars];

    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    failed = NO;
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(fetchAuthTokenComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(fetchAuthTokenFailed:)];
    [networkQueue setDelegate:self];

    ASIHTTPRequest *request;
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:SESSIONS_URL]];
    NSString *json = @"merchant[email]=fran@greenbean.com&merchant[password]=password";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setPostBody:(NSMutableData *)data];

    [networkQueue addOperation:request];

    [networkQueue go];

} /* fetchThreeImages */


/*
   FetchAuthTokenFailed
   --------
   Purpose:        Selector for Queue Failure
   Parameters:     none
   Returns:        none
   Notes:          Handles Failure
   Author:         Neil Burchfield
 */
- (void) fetchAuthTokenFailed:(ASIHTTPRequest *)request {
    NSLog(@"Response_token %d ==> %@", request.responseStatusCode, [request responseString]);
} /* fetchTokenFailed */


/*
   FetchAuthTokenComplete
   --------
   Purpose:        Selector for Queue Success
   Parameters:     none
   Returns:        none
   Notes:          Sets Authentication Token var in Delegate Class
   Author:         Neil Burchfield
 */
- (void) fetchAuthTokenComplete:(ASIHTTPRequest *)request {

    NSString *responseString = [request responseString];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];

    NSDictionary *merchant_body = [JSON valueForKey:@"merchant"];
    authenticationToken = [merchant_body valueForKey:@"authentication_token"];

    [AppDelegate setMerchantAuthenticationToken:authenticationToken];

    NSLog(@"Success: %@", [AppDelegate getMerchantAuthenticationToken]);
    
    self.cache = [[CacheTokenObjects alloc] init];
    [self.cache fillApplicationTokenSets];
} /* fetchAuthTokenComplete */


@end
