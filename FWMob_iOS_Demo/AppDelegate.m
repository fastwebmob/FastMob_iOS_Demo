//
//  AppDelegate.m
//  FWMob_iOS_Demo
//
//  Created by fastweb on 9/24/15.
//  Copyright © 2015 fastweb. All rights reserved.
//

#import "AppDelegate.h"
#import <FWMobSDK/FWMobService.h>

#define DEVKEY  @"$2a$08$XEjJ3gp6eelk/8yA53h3oORJ3nm.Vd38W2It5qjY4HyeApxo.jw.m"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FWMobService start:DEVKEY];
    
    [FWMobService debugOn:YES];
    
    //如果需要可强制指定压缩级别
    [FWMobService setCompressionLevel:FWCompressionHigh];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //如果需要，可以在进入后台时，停止服务
//    [FWMobService stop];
    
    //如果需要，可以在进入后台时，延时停止服务
//    [FWMobService delayStopWithTime:10.f];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //如果需要，可以在进入前台时，开启服务
//    [FWMobService start:DEVKEY];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
