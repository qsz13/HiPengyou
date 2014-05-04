//
//  HPConversationThread.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPUser.h"
#import "HPMessage.h"

@interface HPConversationThread : NSObject

@property (strong, nonatomic) NSMutableArray *messageList;
@property (strong, nonatomic) HPUser *chatter;

- (void)addMessage:(HPMessage *)message;




@end
