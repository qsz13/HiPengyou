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
        [self initNameLabel];
        [self initContentLabel];
        
    }
    
    return self;
}


- (void)initNameLabel
{
    self.nameLabel = [[UILabel alloc]init];

    [self.nameLabel resetSize:CGSizeMake(200, 30)];
    self.nameLabel.numberOfLines = 1;
    [self.nameLabel setText:self.message.sender.username];
    [self.nameLabel sizeToFit];
    

    [self.nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.nameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                 green:188.0f / 255.0f
                                                  blue:235.0f / 255.0f
                                                 alpha:1]];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
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
    [self.contentLabel sizeToFit];
    
    
    [self.contentLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                 green:188.0f / 255.0f
                                                  blue:235.0f / 255.0f
                                                 alpha:1]];
    [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentLabel setBackgroundColor:[UIColor clearColor]];
    
    [self.contentLabel resetOrigin:CGPointMake(0, [self.nameLabel getHeight])];
    [self addSubview:self.contentLabel];
}






@end
