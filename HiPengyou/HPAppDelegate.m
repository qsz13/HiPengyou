//
//  HPAppDelegate.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPAppDelegate.h"
#import "HPLoginViewController.h"
#import "HPMessageViewController.h"
#import "HPProfileViewController.h"
#import "HPRootTabBarController.h"

@implementation HPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.tabBarController = [[HPRootTabBarController alloc] init];
    [self.tabBarController.view setBackgroundColor:[UIColor clearColor]];
    
    HPMessageViewController *messageViewController = [[HPMessageViewController alloc] init];
    HPProfileViewController *profileViewController = [[HPProfileViewController alloc] init];
    UINavigationController *messageNavigationController = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    self.tabBarController.viewControllers = @[messageNavigationController, profileNavigationController];
    
    HPLoginViewController *loginViewController = [[HPLoginViewController alloc] init];

    // Set window background color
    [self.window setBackgroundColor:[UIColor colorWithRed:49.0f / 225.0f
                                                    green:188.0f / 255.0f
                                                     blue:234.0f / 255.0f
                                                    alpha:1]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.tabBarController;
    NSLog(@"!!!!");
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults boolForKey:@"isLoggedIn"]){
        NSLog(@"not log");
        [self.tabBarController presentViewController:loginViewController animated:NO completion:nil];
    }
    

    return YES;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

@end
