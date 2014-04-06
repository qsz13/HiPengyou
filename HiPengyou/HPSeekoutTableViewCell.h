//
//  HPSeekoutTableViewCell.h
//  HiPengyou
//
//  Created by Tom Hu on 4/4/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekout.h"
@interface HPSeekoutTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPSeekout*)seekout;
- (void)addViewMoreButtonAction:(SEL)selector;

@end
