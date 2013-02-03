//
//  RetrieveSingleToken.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/20/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "RetrieveSingleTokenSet.h"

#define TOKEN_URL @"http://greenbean.herokuapp.com/api/tokens.json"

/* Private stuff */
@interface RetrieveSingleTokenSet ()
- (void) fetchTokenComplete:(ASIHTTPRequest *)request;
- (void) fetchTokenFailed:(ASIHTTPRequest *)request;
@end

@implementation RetrieveSingleTokenSet

/*
   FillApplicationTokenSets
   --------
   Purpose:        Load tokens into Cached object
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) refillTokenSet:(int)set {

    authenticationToken = [AppDelegate getMerchantAuthenticationToken];

    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(fetchTokenComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(fetchTokenFailed:)];
    [networkQueue setDelegate:self];

    NSURL *token_url = [NSURL URLWithString:TOKEN_URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:token_url];

    NSString *json = [NSString stringWithFormat:@"auth_token=%@&quantity=%d", authenticationToken, set];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

    [request setPostBody:(NSMutableData *)data];
    [networkQueue addOperation:request];

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
    /*NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[[request responseString] dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];

    NSString *token = [JSON valueForKey:@"token"];
    int quantity = [[JSON valueForKey:@"quantity"] intValue]; */
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

