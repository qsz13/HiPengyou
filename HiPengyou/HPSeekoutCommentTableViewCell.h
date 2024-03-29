//
//  HPSeekoutReplyTableViewCell.h
//  HiPengyou
//
//  Created by Tom Hu on 4/11/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekoutComment.h"

@interface HPSeekoutCommentTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPSeekoutComment *)comment;

@end
