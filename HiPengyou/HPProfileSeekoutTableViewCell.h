//
//  HPProfileSeekoutTableViewCell.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/24/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekout.h"

@interface HPProfileSeekoutTableViewCell : UITableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPSeekout*)seekout;

@end
