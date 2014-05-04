//
//  HPConversationThread.m
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPConversationThread.h"

@implementation HPConversationThread

- (id)init
{
    self = [super init];
    if(self)
    {
        self.messageList = [[NSMutableArray alloc]init];
        
        
    }
    return self;
}

- (void)addMessage:(HPMessage *)message
{
    [self.messageList addObject:message];
    
    
    
}




@end
