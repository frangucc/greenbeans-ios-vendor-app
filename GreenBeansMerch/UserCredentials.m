//
//  UserCredentials.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/31/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "UserCredentials.h"

#define USERNAME_PLIST     @"login-email.plist"
#define USERNAME_PLIST_KEY @"user"
#define REMEMBER_ME_PLIST_KEY @"reme"

@implementation UserCredentials

- (BOOL) initilize {
    BOOL success = NO;
    if ([self plistExists]) {
        if ([self fetchUsernameAndStateFromPlist]) {
            NSString *passForPlistUser = [Lockbox stringForKey:[self getUsernamePlist]];
            if ((passForPlistUser != nil) || [passForPlistUser isEqualToString:@""]) {
                [self setPasswordFromKeyChain:passForPlistUser];
                [self setUsernameFromKeyChain:[self getUsernamePlist]];
                success = YES;
            }
        } else {
            NSLog(@"PLIST DOESNT HAVE USERNAME");
            [self setPasswordFromKeyChain:@""];
            [self setUsernameFromKeyChain:@""];
        }
    }
    else
    {
        NSLog(@"NO PLIST");
    }
    return success;
} /* initilize */


- (BOOL) setUsernameIntoKeyChainWithPassword:(NSString *)user :(NSString *)pass {
    return [Lockbox setString:pass forKey:user];
} /* setUsernameIntoKeyChainWithPassword */


- (void) setUsernameFromKeyChain:(NSString *)user {
    login_username_keychain = [user copy];
} /* setUsernameFromKeyChain */


- (NSString *) getUsernameFromKeyChain {
    return login_username_keychain;
} /* getUsernameFromKeyChain */


- (void) setUsernameFromPlist:(NSString *)user {
    login_username_plist = [user copy];
} /* setUsernameFromPlist */


- (NSString *) getUsernamePlist {
    return login_username_plist;
} /* getUsernamePlist */


- (void) setRememberMeFromPlist:(BOOL)flag {
    rememberMeState = flag;
} /* setRememberMeFromPlist */


- (BOOL) getRememberMeFromPlist {
    return rememberMeState;
} /* getRememberMeFromPlist */


- (void) setPasswordFromKeyChain:(NSString *)pass {
    login_password_keychain = [pass copy];
} /* setPasswordFromKeyChain */


- (NSString *) getPasswordFromKeyChain {
    return login_password_keychain;
} /* getPasswordFromKeyChain */


- (BOOL) plistExists {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:USERNAME_PLIST];
    NSLog(@"Docs-Dir: %@", documentsDirectory);
    return [[NSFileManager defaultManager] fileExistsAtPath:plistLocation];
} /* plistExists */


- (BOOL) writeUsernameAndStateToPlist :(NSString *)user :(BOOL)state {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:USERNAME_PLIST];
    NSMutableDictionary *userkey = [[NSMutableDictionary alloc] init];
    
    [userkey setObject:user forKey:USERNAME_PLIST_KEY];    
    [userkey setObject:[NSNumber numberWithBool:state] forKey:REMEMBER_ME_PLIST_KEY];
    [userkey writeToFile:filePath atomically:YES];

    return [self plistExists];
} /* writeUsernameToPlist */


- (BOOL) fetchUsernameAndStateFromPlist {

    if ([self plistExists]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:USERNAME_PLIST];

        NSMutableDictionary *userNameDict;
        NSString *userName;
        BOOL remMeState = NO;
            userNameDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            userName = [userNameDict objectForKey:USERNAME_PLIST_KEY];
            [self setUsernameFromPlist:userName];
            remMeState = [[userNameDict objectForKey:REMEMBER_ME_PLIST_KEY] boolValue];
            [self setRememberMeFromPlist:remMeState];
        return YES;
    }

    return NO;
} /* fetchUsernameFromPlist */


@end


















