//
//  HPUser.m
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPUser.h"

@implementation HPUser

- (id)copyWithZone:(NSZone *)zone
{
    
    id newUser = [[[self class] alloc]init];
    if (newUser) {
        [newUser setUsername:[self.username copyWithZone:zone]];
        [newUser setUserID:self.userID];
        [newUser setUserFaceURL:[self.userFaceURL copyWithZone:zone]];
    }
    

    return newUser;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:self.class] && ((HPUser *)object).userID == self.userID) {
        return YES;
    }
    return NO;
}

@end
