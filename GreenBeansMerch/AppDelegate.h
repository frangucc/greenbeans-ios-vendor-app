//
//  AppDelegate.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "UserCredentials.h"
#import "RootViewController_iPad.h"

@class RootViewController_iPad;
@class RootViewController;
@class Reachability;

/*
 AppDelegate Interface
 --------
 Delegate:        UIResponder
 Inheritance:     UIApplicationDelegate, UINavigationControllerDelegate
 Author:          Neil Burchfield
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rvc;
@property (strong, nonatomic) RootViewController_iPad *rvc_iPad;
@property (strong, nonatomic) Reachability* hostReach;
@property (strong, nonatomic) Reachability* internetReach;
@property (strong, nonatomic) Reachability* wifiReach;
@property (strong, nonatomic) UserCredentials* userCredentials;

/*
 AppDelegate's External Methods
 --------
 Notes:           Merchant's Getters/Setters
 Author:          Neil Burchfield
 */
+ (NSString *) getPortName;
+ (void) setPortName:(NSString *)m_portName;
+ (NSString *) getPortSettings;
+ (void) setPortSettings:(NSString *)m_portSettings;
+ (int) beanCount;
+ (void) setBeanCount:(int)beans;
+ (NSString *) getMerchantAuthenticationToken;
+ (void) setMerchantAuthenticationToken:(NSString *)token;
+ (NSString *) getMerchantEmail;
+ (void) setMerchantEmail:(NSString *)email;
+ (NSString *) getMerchantPassword;
+ (void) setMerchantPassword:(NSString *)pass;
+ (NSString *) getRecentUrlStatus;
+ (void) setRecentUrlStatus:(NSString *)status;
+ (int) getQuantity;
+ (void) setQuantity:(int)qt;
+ (NSString *) getMerchantToken;
+ (void) setMerchantToken:(NSString *)tok;
+ (BOOL) getNetworkAvailibility;
+ (void) setNetworkAvailibility:(BOOL)net;
+ (BOOL) getPrinterAvailibility;
+ (void) setPrinterAvailibility:(BOOL)bt;
+ (BOOL) getRememberMeState;
+ (void) setRememberMeState:(BOOL)flag;
@end
