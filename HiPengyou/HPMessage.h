//
//  HPMessage.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPUser.h"

@interface HPMessage : NSObject

@property NSInteger messageID;
@property (strong, nonatomic) HPUser *sender;
@property (strong, nonatomic) HPUser *reciever;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *time;
@property NSInteger status;
@property BOOL hasMedia;
@property BOOL sentByMe;
@end
