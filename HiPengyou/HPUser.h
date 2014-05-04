//
//  HPUser.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPUser : NSObject <NSCopying>

@property NSInteger userID;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSURL *userFaceURL;

@end
