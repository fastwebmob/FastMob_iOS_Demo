//
//  AppDelegate.m
//  FWMob_iOS_Demo
//
//  Created by fastweb on 9/24/15.
//  Copyright © 2015 fastweb. All rights reserved.
//

#import "AppDelegate.h"
#import <FWMobSDK/FWMobService.h>
#import "Constants.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FWMobService start:APP_DEV_KEY];
    
    [FWMobService debugOn:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //如果需要，可以在进入后台时，停止服务
//    [FWMobService stop];
    
    //如果需要，可以在进入后台时，延时停止服务
    [FWMobService delayStopWithTime:10.f];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //如果需要，可以在进入前台时，开启服务
    [FWMobService start:APP_DEV_KEY];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
