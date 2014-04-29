//
//  HPSeekout.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPSeekoutType.h"

@interface HPSeekout : NSObject

@property NSInteger seekoutID;
@property (strong, atomic) NSString *content;
@property (strong, atomic) NSString *author;
@property NSInteger commentNumber;
@property (strong, atomic) NSString *state;
@property HPSeekoutType type;
@property (strong, atomic) NSString *time;
@property (strong, atomic) NSURL *faceImageURL;

@end
