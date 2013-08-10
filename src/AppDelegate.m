//
//  AppDelegate.m
//  werewolves
//
//  Created by Phil Dougherty on 7/30/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "AppDelegate.h"
#import "WerewolvesRootViewcontroller.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGRect appFrame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20); //screen - status bar
    WerewolvesRootViewcontroller *wrvc = [[WerewolvesRootViewcontroller alloc] initWithViewFrame:appFrame];
    [self.window setRootViewController:wrvc];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
