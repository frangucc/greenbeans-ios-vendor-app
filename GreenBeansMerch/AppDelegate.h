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


@end
