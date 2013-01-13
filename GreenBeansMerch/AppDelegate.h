//
//  AppDelegate.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rvc;

+ (NSString*)getPortName;
+ (void)setPortName:(NSString *)m_portName;
+ (NSString*)getPortSettings;
+ (void)setPortSettings:(NSString *)m_portSettings;

+ (int)beanCount;
+ (void)setBeanCount:(int)beans;
+ (NSString *)getMerchantAuthenticationToken;
+ (void)setMerchantAuthenticationToken:(NSString *)token;
+ (NSString *)getMerchantEmail;
+ (void)setMerchantEmail:(NSString *)email;
+ (NSString *)getMerchantPassword;
+ (void)setMerchantPassword:(NSString *)pass;
+ (NSString *)getRecentUrlStatus;
+ (void)setRecentUrlStatus:(NSString *)status;
+ (int)getQuantity;
+ (void)setQuantity:(int)qt;
+ (NSString *)getMerchantToken;
+ (void)setMerchantToken:(NSString *)tok;

@end
