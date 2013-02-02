//
//  AuthenticateMerchantLogin.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/20/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "AuthenticateMerchantLogin.h"

#define SESSIONS_URL @"http://greenbean.herokuapp.com/api/sessions.json"

@implementation AuthenticateMerchantLogin
@synthesize loginSuccessful = _loginSuccessful;

/*
 InitilizeConcurrentAPISession
 --------
 Purpose:        Initilizes ROR API Session
 Parameters:     none
 Returns:        none
 Notes:          Sets Authentication Token for Entire Session
 Author:         Neil Burchfield
 */
- (bool) loginMerchantWithCredentials {
    
    if (!loginRequest) {
        loginRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:SESSIONS_URL]];
    }
    
    NSLog(@"[AuthenticateMerchantLogin] Credentials: %@, %@", [AppDelegate getMerchantEmail], [AppDelegate getMerchantPassword]);
    NSString *json = [NSString stringWithFormat:@"merchant[email]=%@&merchant[password]=%@", [AppDelegate getMerchantEmail], [AppDelegate getMerchantPassword]];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [loginRequest setPostBody:(NSMutableData *)data];
    [loginRequest startSynchronous];

    NSLog(@"loginRequest: %@", [loginRequest responseString]);

    return [self fetchAuthTokenComplete:loginRequest];
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
    NSLog(@"[AuthenticateMerchantLogin] Response_token %d ==> %@", request.responseStatusCode, [request responseString]);
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
- (bool) fetchAuthTokenComplete:(ASIHTTPRequest *)request {
    
    NSString *responseString = [request responseString];
    
    if (responseString == NULL) {
        [self performSelector:@selector(loginMerchantWithCredentials) withObject:nil afterDelay:.3f];
        
        if (serverInterationCount >= 10)
            return NO;
        
        serverInterationCount++;
    }
    
    NSError *error;
    NSLog(@"[%@] => Response: %@", [self class], responseString);
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    
    if (error != nil)
        NSLog(@"[AuthenticateMerchantLogin]=>[fetchAuthTokenComplete]: [Error]-> %@", error);
    
    NSDictionary *merchant_body = [JSON valueForKey:@"merchant"];
    authenticationToken = [merchant_body valueForKey:@"authentication_token"];
    
    if (authenticationToken != nil)
    {
        [AppDelegate setMerchantAuthenticationToken:authenticationToken];
        
        NSLog(@"[AuthenticateMerchantLogin] Login Success");
        NSLog(@"[AuthenticateMerchantLogin] Token: %@", [AppDelegate getMerchantAuthenticationToken]);
        
        return YES;
    }
    else
    {
        NSLog(@"[AuthenticateMerchantLogin] Login Failed");
        return NO;
    }

} /* fetchAuthTokenComplete */

@end
