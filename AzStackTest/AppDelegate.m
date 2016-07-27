//
//  AppDelegate.m
//  AzStackTest
//
//  Created by Phu Nguyen on 6/22/15.
//  Copyright (c) 2015 Phu Nguyen. All rights reserved.
//

#import "AppDelegate.h"
#import "AzStackTestController.h"
#import <AzStack/AzStackManager.h>
#import <AzStack/AzStackUser.h>
#import "ThirdPartyImplement.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set APP ID
    [[AzStackManager instance] setAppId:@"26870527d2ac628002dda81be54217cf"];
    // Set APP PUBLIC KEY
    [[AzStackManager instance] setPublicKey:@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq9s407QkMiZkXF0juCGjti6iWUDzqEmP+Urs3+g2zOf+rbIAZVZItS5a4BZlv3Dux3Xnmhrz240OZMBO1cNc poEQNij1duZlpJY8BJiptlrj3C+K/PSp0ijllnckwvYYpApm3RxC8ITvpmY3IZTrRKloC/XoRe39p68ARtxXKKW5I/YYxFucY91b6AEOUNaqMFEdLzpO/Dgccaxoc+N1SMfZOKue7aH0ZQIksLN7OQGVoiuf9wR2iSz3+FA+mMzRIP+lDxI4JE42Vvn1sYmMCY1GkkWUSzdQsfgnAIvnbepM2E4/95yMdRPP/k2Qdq9ja/mwEMTfA0yPUZ7LiywoZwIDAQAB"];
    
    // SET AZSTACK DELEGATE
    [AzStackManager instance].azUserInfoDelegate = [ThirdPartyImplement instance];
    [AzStackManager instance].azChatDelegate = [ThirdPartyImplement instance];
    [AzStackManager instance].azCallDelegate = [ThirdPartyImplement instance];
    
    // INITIAL
    [[AzStackManager instance] setTintColorNavigationBar:[UIColor blackColor]];
    [[AzStackManager instance] setLanguage:@"en"];
    [[AzStackManager instance] setDebugLog:YES];
    [[AzStackManager instance] initial];
    
    AzStackTestController * azStackTestController = [[AzStackTestController alloc] init];
    azStackTestController.title = @"Authenticating ...";
    
    // CONNECT
    [[AzStackManager instance] connectWithAzStackUserId:@"ios_user1" userCredentials:@"ios_user1_credentials" fullname:@"iOS User 1" completion:^(NSString *authenticatedAzStackUserID, NSError *error, BOOL successful) {
        if (successful) {
            NSLog(@"Authent successful, authenticatedAzStackUserID: %@", authenticatedAzStackUserID);
            dispatch_async(dispatch_get_main_queue(), ^{
                azStackTestController.title = [NSString stringWithFormat:@"Your azStackUserID: %@", authenticatedAzStackUserID];
            });
        } else {
            NSLog(@"Authent failed. ResponseCode: %ld. Error Message: %@", (long)error.code, [error description]);
        }
    }];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -200) forBarMetrics:UIBarMetricsDefault];
    }
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:azStackTestController];
    navController.navigationBar.translucent = NO;
    
    self.window.rootViewController = navController;
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
