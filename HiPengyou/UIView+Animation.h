//
//  UIView+Animation.h
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void)fadeIn;
- (void)fadeInWithCompletion:(void (^)(void))completion;
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)(void))completion;

@end