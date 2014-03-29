//
//  UIView+Resize.h
//  HiPengyou
//
//  Created by Tom Hu on 3/29/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Resize)

- (void)resetOriginX:(CGFloat)originX;
- (void)resetOriginY:(CGFloat)originY;
- (void)resetOriginYByOffset:(CGFloat)offset;
- (void)resetOriginXByOffset:(CGFloat)offset;
- (void)resetOrigin:(CGPoint)origin;

- (void)resetCenterY:(CGFloat)centerY;
- (void)resetCenterX:(CGFloat)centerX;
- (void)resetCenter:(CGPoint)center;

- (void)resetWidth:(CGFloat)width;
- (void)resetHeight:(CGFloat)height;
- (void)resetHeightByOffset:(CGFloat)offset;
- (void)resetWidthByOffset:(CGFloat)offset;
- (void)resetSize:(CGSize)size;

@end

@interface UIView (Getter)

- (CGFloat)getOriginX;
- (CGFloat)getOriginY;
- (CGPoint)getOrigin;

- (CGFloat)getCenterY;
- (CGFloat)getCenterX;
- (CGPoint)getCenter;

- (CGFloat)getWidth;
- (CGFloat)getHeight;
- (CGSize)getSize;

@end