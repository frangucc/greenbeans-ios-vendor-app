//
//  ConnectServer.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "ConnectServer.h"
#import "CreateTokenFromServer.h"

#define TEST_EMAIL @"fran@greenbean.com"
#define TEST_PASS  @"password"

@implementation ConnectServer

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
   ActivateSessionWithPOST
   --------
   Purpose:        Create Post Session
   Parameters:     create -   to create...or not to
                 quantity - bean quantity
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) activateSessionWithPOST :(bool)create :(int)quantity {

    createToken = create;

    if (createToken) {
        [AppDelegate setQuantity:quantity];
    }

    NSString *json = @"merchant[email]=fran@greenbean.com&merchant[password]=password";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greenbean.herokuapp.com/api/sessions.json"]];
    [url setHTTPBody:data];
    [url setHTTPMethod:@"POST"];
    (void)[[NSURLConnection alloc] initWithRequest:url delegate:self];

} /* activateSessionWithPOST */


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

    NSDictionary *merchant_body = [parsedData valueForKey:@"merchant"];
    NSLog(@"merchant_body: %@", merchant_body);

    NSArray *authToken = [merchant_body valueForKey:@"authentication_token"];
    NSLog(@"authToken: %@", authToken);

    [AppDelegate setMerchantAuthenticationToken:[merchant_body valueForKey:@"authentication_token"]];

    if (createToken) {
        CreateTokenFromServer *ct = [[CreateTokenFromServer alloc] init];
        [ct createTokenWithPOST:[AppDelegate getQuantity]];
    }
} /* connectionDidFinishLoading */


@end
