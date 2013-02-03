//
//  CacheTokenObjects.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/19/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "CacheTokenObjects.h"

#define TOKEN_URL @"http://greenbean.herokuapp.com/api/tokens.json"

/* Private stuff */
@interface CacheTokenObjects ()
- (void) fetchTokenComplete:(ASIHTTPRequest *)request;
- (void) fetchTokenFailed:(ASIHTTPRequest *)request;
@end

@implementation CacheTokenObjects
@synthesize cache = _cache;

/*
   FillApplicationTokenSets
   --------
   Purpose:        Load tokens into Cached object
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) fillApplicationTokenSets {

    /* Init Cached Object */
    self.cache = [[CachedTokenSets alloc] init];
    
    authenticationToken = [AppDelegate getMerchantAuthenticationToken];

    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(fetchTokenComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(fetchTokenFailed:)];
    [networkQueue setDelegate:self];

    for (int foo = 1; foo <= 10; foo++) {
        for (int bar = 1; bar <= 2; bar++) {
            NSURL *token_url = [NSURL URLWithString:TOKEN_URL];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:token_url];

            NSString *json = [NSString stringWithFormat:@"auth_token=%@&quantity=%d", authenticationToken, foo];
            NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

            [request setPostBody:(NSMutableData *)data];
            [networkQueue addOperation:request];
        }
    }

    [networkQueue go];

} /* fetchToken */


/*
   FetchTokenComplete
   --------
   Purpose:        ASINetworkQueue Delegate Completion
   Parameters:     none
   Returns:        none
   Notes:          Sets Object's Token's per Quantity
   Author:         Neil Burchfield
 */
- (void) fetchTokenComplete:(ASIHTTPRequest *)request {
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[[request responseString] dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];

    NSString *token = [JSON valueForKey:@"token"];
    int quantity = [[JSON valueForKey:@"quantity"] intValue];

    [self.cache setSets:quantity:token];

    NSLog(@"Token Set 1: %@", [self.cache getSet:1]);

} /* fetchTokenComplete */


/*
   FetchTokenFailed
   --------
   Purpose:        ASINetworkQueue Delegate Failure
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) fetchTokenFailed:(ASIHTTPRequest *)request {
    NSLog(@"fetchTokenFailed %d ==> %@", request.responseStatusCode, [request responseString]);
} /* fetchTokenFailed */


/*
   Dealloc
   --------
   Purpose:        Reset Queue
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) dealloc {
    [networkQueue reset];
} /* dealloc */


@end

