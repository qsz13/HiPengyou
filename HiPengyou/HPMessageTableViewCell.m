//
//  HPMessageTableViewCell.m
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPMessageTableViewCell.h"
#import "UIView+Resize.h"

@interface HPMessageTableViewCell ()

@property (strong, nonatomic) HPMessage *message;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property NSInteger userID;

@end


@implementation HPMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPMessage *)message
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.message = message;
        self.frame = frame;
        [self initData];
        [self initNameLabel];
        [self initContentLabel];
        
    }
    
    return self;
}

- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userID = [userDefaults integerForKey:@"id"];
}



- (void)initNameLabel
{
    self.nameLabel = [[UILabel alloc]init];

    [self.nameLabel resetSize:CGSizeMake([self getWidth], 30)];
    self.nameLabel.numberOfLines = 1;
    [self.nameLabel setText:self.message.sender.username];
//    [self.nameLabel sizeToFit];
    if(self.message.sender.userID == self.userID)
    {
        [self.nameLabel setTextAlignment:NSTextAlignmentRight];
    }
    
    else
    {
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];

    }

    [self.nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.nameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                 green:188.0f / 255.0f
                                                  blue:235.0f / 255.0f
                                                 alpha:1]];
    
    
    
    [self.nameLabel setBackgroundColor:[UIColor clearColor]];

    [self.nameLabel resetOrigin:CGPointMake(0, 0)];
    [self addSubview:self.nameLabel];
    
}

- (void)initContentLabel
{
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel resetSize:CGSizeMake([self getWidth], 30)];
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel setText:self.message.content];
//    [self.contentLabel sizeToFit];
    
    
    [self.contentLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                 green:188.0f / 255.0f
                                                  blue:235.0f / 255.0f
                                                 alpha:1]];
    if(self.message.sender.userID == self.userID)
    {
        [self.contentLabel setTextAlignment:NSTextAlignmentRight];
    }
    
    else
    {
        [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
        
    }
    
   
    
    [self.contentLabel resetOrigin:CGPointMake(0, [self.nameLabel getHeight]-5)];
    [self addSubview:self.contentLabel];
}






@end
