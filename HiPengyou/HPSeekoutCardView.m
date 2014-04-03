//
//  HPSeekoutCardView.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/3/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCardView.h"

@implementation HPSeekoutCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBackground];
        [self initButton];
    }
    return self;
}

- (void)initBackground
{
    [self setBackgroundColor:[UIColor colorWithRed:244.0f / 255.0f
                                                       green:244.0f / 255.0f
                                                        blue:244.0f / 255.0f
                                                       alpha:1]];
}

-(void)initButton
{
    
    
    
}



@end
