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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // TODO
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPSeekout*)seekout
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = frame;
//    [self resetWidthByOffset:80];
    
    NSLog(@"%f, %f, %f, %f", [self getOriginX], [self getOriginY], [self getWidth], [self getHeight]);
    
    if (self) {
        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:frame];
        [seekoutCardView loadData:seekout];
        // Clear Background Color
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        // Add Seekout Card View To Content View
        [self.contentView addSubview:seekoutCardView];
    }
    return self;
}

@end
