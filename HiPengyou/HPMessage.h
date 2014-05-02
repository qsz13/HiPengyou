//
//  HPMessage.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPMessage : NSObject

@property NSInteger messageID;
@property NSInteger senderID;
@property (strong, atomic) NSString *senderName;
@property (strong, atomic) NSURL *senderFaceURL;
@property NSInteger recieverID;
@property (strong, atomic) NSString *recieverName;
@property (strong, atomic) NSURL *recieverFaceURL;
@property (strong, atomic) NSString *content;
@property (strong, atomic) NSString *time;
@property NSInteger status;
@property BOOL hasMedis;

@end
