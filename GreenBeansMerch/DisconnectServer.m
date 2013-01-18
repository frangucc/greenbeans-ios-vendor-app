//
//  DisconnectServer.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

/* Imports */
#import "DisconnectServer.h"

/* Definitions */
#define TEST_EMAIL @"fran@greenbean.com"
#define TEST_PASS  @"password"

// curl -X POST 'http://greenbean.herokuapp.com/api/sessions.json' -d
// 'merchant[email]=fran@greenbean.com&merchant[password]=password'
@implementation DisconnectServer

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
   DisconnectSessionWithPOST
   --------
   Purpose:        Terminate Post Session
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) disconnectSessionWithPOST {
//    curl -X POST 'http://greenbean.herokuapp.com/api/sessions/delete.json' -d 'auth_token='
    NSString *json = [NSString stringWithFormat:@"auth_token=%@", [AppDelegate getMerchantAuthenticationToken]];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greenbean.herokuapp.com/api/sessions/delete.json"]];
    [url setHTTPBody:data];
    [url setHTTPMethod:@"POST"];
    (void)[[NSURLConnection alloc] initWithRequest:url delegate:self];
} /* disconnectSessionWithPOST */


/*
   DidReceiveResponse
   --------
   Purpose:        Wait for URL response / Alloc data array
   Author:         Neil Burchfield
 */
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
} /* connection */


/*
   DidReceiveData
   --------
   Purpose:        Append incoming data
   Author:         Neil Burchfield
 */
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
} /* connection */


/*
   DidFailWithError
   --------
   Purpose:        Handle URL Failure
   Author:         Neil Burchfield
 */
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Unable to fetch data");
} /* connection */


/*
   ConnectionDidFinishLoading
   --------
   Purpose:        Parse data
   Author:         Neil Burchfield
 */
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data", [responseData length]);

    NSDictionary *parsedData = [NSJSONSerialization
                                JSONObjectWithData:responseData // 1

                                           options:kNilOptions
                                             error:nil];

    // Response Data is the JSON String
    NSLog(@"Parsed Data: %@", parsedData);

    NSDictionary *merchant_body = [parsedData valueForKey:@""];
    NSLog(@"merchant_body: %@", merchant_body);

    NSArray *authToken = [merchant_body valueForKey:@"error"];
    NSLog(@"error: %@", authToken);

    [AppDelegate setRecentUrlStatus:[merchant_body valueForKey:@"status"]];
} /* connectionDidFinishLoading */


@end
