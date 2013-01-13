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
#define TEST_PASS @"password"

@implementation ConnectServer
- (void) initVars
{
    [AppDelegate setMerchantPassword:TEST_PASS];
    [AppDelegate setMerchantEmail:TEST_EMAIL];
}

- (void) activateSessionWithPOST:(bool)create :(int)quantity {
    
    createToken = create;
    
    if (createToken) { [AppDelegate setQuantity:quantity]; }
    
    NSString * json = @"merchant[email]=fran@greenbean.com&merchant[password]=password";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greenbean.herokuapp.com/api/sessions.json"]];
    [url setHTTPBody:data];
    [url setHTTPMethod:@"POST"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:url delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Unable to fetch data");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[responseData length]);
    
    NSDictionary *parsedData = [NSJSONSerialization
                               JSONObjectWithData:responseData //1
                               
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
}

@end
