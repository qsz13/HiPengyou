//
//  HPAppDelegate.h
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <FacebookSDK/FacebookSDK.h>
@interface HPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *homeNavigationController;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@end
