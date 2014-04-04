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
        [self initLabel];
        [self initImageView];
        [self initContentView];
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

- (void)initLabel
{
    
}

- (void)initImageView
{
    self.seekoutTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypePeopleImage"]];
    [self.seekoutTypeImageView setFrame:CGRectMake(20, 0, 29, 41)];
    [self addSubview:self.seekoutTypeImageView];
    
    
    
}

- (void)initContentView
{
    
}

-(void)initButton
{
    
    
    
}



@end
