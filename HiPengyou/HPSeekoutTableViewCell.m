//
//  HPSeekoutTableViewCell.m
//  HiPengyou
//
//  Created by Tom Hu on 4/4/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutTableViewCell.h"
#import "HPSeekoutCardView.h"
#import "UIView+Resize.h"

@interface HPSeekoutTableViewCell ()



@end

@implementation HPSeekoutTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = frame;
    [self resetWidthByOffset:20];
    
    NSLog(@"Seekout Table View Cell: %f, %f, %f, %f",
          [self getOriginX],
          [self getOriginY],
          [self getWidth],
          [self getHeight]);
    NSLog(@"Seekout Table View Cell Content View: %f, %f, %f, %f",
          [self.contentView getOriginX],
          [self.contentView getOriginY],
          [self.contentView getWidth],
          [self.contentView getHeight]);
    
    if (self) {
        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:frame];
        [seekoutCardView resetOriginXByOffset:10];
        
        // Clear Background Color
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        // Bg View
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        [bgView resetWidthByOffset:20];
        bgView.backgroundColor = [UIColor clearColor];
        
        // Add Seekout Card View To Content View
        [bgView addSubview:seekoutCardView];
        [self.contentView addSubview:bgView];
    }
    return self;
}

@end
