//
//  UIView+Animation.m
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)fadeIn {
    [self fadeInWithCompletion:nil];
}

- (void)fadeInWithCompletion:(void (^)(void))completion {
    self.alpha = 0;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        
        if (completion) {
            completion();
        }
    }];
}

- (void)fadeOut {
    [self fadeOutWithCompletion:nil];
}

- (void)fadeOutWithCompletion:(void (^)(void))completion {
    self.alpha = 1;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        
        if (completion) {
            completion();
        }
    }];
}

@end
