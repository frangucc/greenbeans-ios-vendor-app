//
//  DisconnectServer.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/13/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "DisconnectServer.h"
#define TEST_EMAIL @"fran@greenbean.com"
#define TEST_PASS @"password"

//curl -X POST 'http://greenbean.herokuapp.com/api/sessions.json' -d
// 'merchant[email]=fran@greenbean.com&merchant[password]=password'
@implementation DisconnectServer

- (void) initVars
{
    [AppDelegate setMerchantPassword:TEST_PASS];
    [AppDelegate setMerchantEmail:TEST_EMAIL];
}

- (void) disconnectSessionWithPOST {
//    curl -X POST 'http://greenbean.herokuapp.com/api/sessions/delete.json'
//    -d 'auth_token='
    NSString * json = [NSString stringWithFormat:@"auth_token=%@",[AppDelegate getMerchantAuthenticationToken]];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greenbean.herokuapp.com/api/sessions/delete.json"]];
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
    
    // Response Data is the JSON String
    NSLog(@"Parsed Data: %@", parsedData);

    NSDictionary *merchant_body = [parsedData valueForKey:@""];
    NSLog(@"merchant_body: %@", merchant_body);

    NSArray *authToken = [merchant_body valueForKey:@"error"];
    NSLog(@"error: %@", authToken);
    
    [AppDelegate setRecentUrlStatus:[merchant_body valueForKey:@"status"]];
}

@end
