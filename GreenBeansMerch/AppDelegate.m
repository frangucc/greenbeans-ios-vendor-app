//
//  AppDelegate.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

#define GREEN_BEAN_HOST @"www.apple.com"

static NSString *portName = nil;
static NSString *portSettings = nil;
static NSString *merchantAuthenticationToken = nil;
static NSString *merchantEmail = nil;
static NSString *merchantPassword = nil;
static NSString *urlStatus = nil;
static NSString *token = nil;
static int beanQuantity = -1;
static int beanCount = -1;
static BOOL network = NO;
static BOOL printer = YES;
static BOOL remember_me;

@implementation AppDelegate
@synthesize window = _window;
@synthesize rvc = _rvc;
@synthesize rvc_iPad = _rvc_iPad;
@synthesize internetReach = _internetReach;
@synthesize hostReach = _hostReach;
@synthesize wifiReach = _wifiReach;
@synthesize userCredentials = _userCredentials;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *rootNavigationViewController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        // Override point for customization after application launch.
        self.rvc_iPad = [[RootViewController_iPad alloc] init];
        rootNavigationViewController = [[UINavigationController alloc] initWithRootViewController:self.rvc_iPad];
    }
    else
    {
        // Override point for customization after application launch.
        self.rvc = [[RootViewController alloc] init];
        rootNavigationViewController = [[UINavigationController alloc] initWithRootViewController:self.rvc];
    }

    
    /* Cache User Credentials From KeyChain */
    self.userCredentials = [[UserCredentials alloc] init];
    if ([self.userCredentials initilize])
    {
        [AppDelegate setMerchantEmail:[self.userCredentials getUsernameFromKeyChain]];
        [AppDelegate setMerchantPassword:[self.userCredentials getPasswordFromKeyChain]];
        [AppDelegate setRememberMeState:[self.userCredentials getRememberMeFromPlist]];
    }

    self.window.rootViewController = rootNavigationViewController;
    [self.window makeKeyAndVisible];

    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];

    // Change the host name here to change the server your monitoring
    _hostReach = [Reachability reachabilityWithHostName:GREEN_BEAN_HOST];
    [_hostReach startNotifier];
    [self updateNetorkStatus:_hostReach];

    _internetReach = [Reachability reachabilityForInternetConnection];
    [_internetReach startNotifier];
    [self updateNetorkStatus:_internetReach];

    _wifiReach = [Reachability reachabilityForLocalWiFi];
    [_wifiReach startNotifier];
    [self updateNetorkStatus:_wifiReach];

    return YES;
} /* application */


+ (void) setBeanCount:(int)beans {
    if (beanCount != beans) {
        beanCount = beans;
    }
} /* setBeanCount */


+ (int) beanCount {
    return beanCount;
} /* beanCount */


+ (NSString *) getPortName {
    return portName;
} /* getPortName */


+ (void) setPortName:(NSString *)m_portName {
    if (portName != m_portName) {
        portName = [m_portName copy];
    }
} /* setPortName */


+ (NSString *) getPortSettings {
    return portSettings;
} /* getPortSettings */


+ (void) setPortSettings:(NSString *)m_portSettings {
    if (portSettings != m_portSettings) {
        portSettings = [m_portSettings copy];
    }
} /* setPortSettings */


+ (NSString *) getMerchantAuthenticationToken {
    return merchantAuthenticationToken;
} /* getMerchantAuthenticationToken */


+ (void) setMerchantAuthenticationToken:(NSString *)token {
    if (merchantAuthenticationToken != token) {
        merchantAuthenticationToken = [token copy];
    }
} /* setMerchantAuthenticationToken */

+ (BOOL) getRememberMeState {
    return remember_me;
} /* getRememberMeState */

+ (void) setRememberMeState:(BOOL)flag {
    remember_me = flag;
    NSLog(@"REMEMBER ME ==> %c", remember_me);
} /* setRememberMeState */

+ (NSString *) getMerchantEmail {
    return merchantEmail;
} /* getMerchantEmail */


+ (void) setMerchantEmail:(NSString *)email {
    if (merchantEmail != email) {
        merchantEmail = [email copy];
    }
    NSLog(@"EMAIL ==> %@", email);
} /* setMerchantEmail */


+ (NSString *) getMerchantPassword {
    return merchantPassword;
} /* getMerchantPassword */


+ (void) setMerchantPassword:(NSString *)pass {
    if (merchantPassword != pass) {
        merchantPassword = [pass copy];
    }
    NSLog(@"PASSWORD ==> %@", pass);
} /* setMerchantPassword */


+ (NSString *) getRecentUrlStatus {
    return urlStatus;
} /* getRecentUrlStatus */


+ (void) setRecentUrlStatus:(NSString *)status {
    if (urlStatus != status) {
        urlStatus = [status copy];
    }
} /* setRecentUrlStatus */


+ (int) getQuantity {
    return beanQuantity;
} /* getQuantity */


+ (void) setQuantity:(int)qt {
    if (beanQuantity != qt) {
        beanQuantity = qt;
    } else
        beanQuantity = 0;
} /* setQuantity */


+ (NSString *) getMerchantToken {
    return token;
} /* getMerchantToken */


+ (void) setMerchantToken:(NSString *)tok {
    if (token != tok) {
        token = tok;
    }
} /* setMerchantToken */


+ (BOOL) getNetworkAvailibility {
    return network;
} /* getNetworkAvailibility */


+ (void) setNetworkAvailibility:(BOOL)net {
    if (network != net) {
        network = net;
    }

    (net) ? NSLog(@"Network Availiable") : NSLog(@"Network NOT Availiable");

} /* setNetworkAvailibility */


+ (BOOL) getPrinterAvailibility {
    return printer;
} /* getPrinterAvailibility */


+ (void) setPrinterAvailibility:(BOOL)bt {
    if (printer != bt) {
        printer = bt;
    }

    (printer) ? NSLog(@"Printer Availiable") : NSLog(@"Printer NOT Availiable");

} /* setPrinterAvailibility */


- (void) applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
} /* applicationWillResignActive */


- (void) applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
} /* applicationDidEnterBackground */


- (void) applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
} /* applicationWillEnterForeground */


- (void) applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
} /* applicationDidBecomeActive */


- (void) applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
} /* applicationWillTerminate */


# pragma Network Status
- (void) updateNetorkStatus:(Reachability *)curReach {
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
        {
            [AppDelegate setNetworkAvailibility:NO];
            break;
        }
        case ReachableViaWWAN:
        {
            [AppDelegate setNetworkAvailibility:YES];
            break;
        }
        case ReachableViaWiFi:
        {
            [AppDelegate setNetworkAvailibility:YES];
            break;
        }
    } /* switch */
} /* updateNetorkStatus */


// Called by Reachability whenever status changes.
- (void) reachabilityChanged:(NSNotification * )note {
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateNetorkStatus:curReach];
} /* reachabilityChanged */


@end
