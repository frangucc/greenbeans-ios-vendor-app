//
//  AppDelegate.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "AppDelegate.h"

static NSString *portName = nil;
static NSString *portSettings = nil;
static NSString *merchantAuthenticationToken = nil;
static NSString *merchantEmail = nil;
static NSString *merchantPassword = nil;
static NSString *urlStatus = nil;
static NSString *token = nil;
static int beanQuantity = -1;
static int beanCount = -1;

@implementation AppDelegate

@synthesize window = _window;
@synthesize rvc = _rvc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.rvc = [[RootViewController alloc] init];
    UINavigationController * rootNavigationViewController = [[UINavigationController alloc] initWithRootViewController:self.rvc];

    self.window.rootViewController = rootNavigationViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (void)setBeanCount:(int)beans
{
    if (beanCount != beans) {
        beanCount = beans;
    }
}

+ (int)beanCount
{
    return beanCount;
}

+ (NSString*)getPortName
{
    return portName;
}

+ (void)setPortName:(NSString *)m_portName
{
    if (portName != m_portName) {
        portName = [m_portName copy];
    }
}

+ (NSString *)getPortSettings
{
    return portSettings;
}

+ (void)setPortSettings:(NSString *)m_portSettings
{
    if (portSettings != m_portSettings) {
        portSettings = [m_portSettings copy];
    }
}

+ (NSString *)getMerchantAuthenticationToken
{
    return merchantAuthenticationToken;
}

+ (void)setMerchantAuthenticationToken:(NSString *)token
{
    if (merchantAuthenticationToken != token) {
        merchantAuthenticationToken = [token copy];
    }
}

+ (NSString *)getMerchantEmail
{
    return merchantEmail;
}

+ (void)setMerchantEmail:(NSString *)email
{
    if (merchantEmail != email) {
        merchantEmail = [email copy];
    }
}

+ (NSString *)getMerchantPassword
{
    return merchantPassword;
}

+ (void)setMerchantPassword:(NSString *)pass
{
    if (merchantPassword != pass) {
        merchantPassword = [pass copy];
    }
}

+ (NSString *)getRecentUrlStatus
{
    return urlStatus;
}

+ (void)setRecentUrlStatus:(NSString *)status
{
    if (urlStatus != status) {
        urlStatus = [status copy];
    }
}

+ (int)getQuantity
{
    return beanQuantity;
}

+ (void)setQuantity:(int)qt
{
    if (beanQuantity != qt) {
        beanQuantity = qt;
    }
}

+ (NSString *)getMerchantToken
{
    return token;
}

+ (void)setMerchantToken:(NSString *)tok
{
    if (token != tok) {
        token = tok;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
