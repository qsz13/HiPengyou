//
//  HPMessageTableViewCell.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPMessage.h"

@interface HPMessageTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPMessage *)message;



@end
