//
//  HPSeekout.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPSeekoutType.h"
#import "HPUser.h"
@interface HPSeekout : NSObject

@property NSInteger seekoutID;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) HPUser *author;
@property NSInteger commentNumber;
@property (strong, nonatomic) NSString *state;
@property HPSeekoutType type;
@property (strong, nonatomic) NSString *time;
//@property (strong, nonatomic) NSURL *faceImageURL;

@end
