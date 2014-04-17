//
//  HPAPIURL.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_URL @"http://quickycard.com:8001/"
#define LOGIN_URL [NSString stringWithFormat:@"%@%@",BASE_URL,@"/index/login"]
#define REGISTER_URL [NSString stringWithFormat:@"%@%@",BASE_URL,@"/index/register"]
#define SEEKOUT_LIST_URL [NSString stringWithFormat:@"%@%@",BASE_URL,@"/seekout/seekoutListForSlide?"]
#define SEEKOUT_CREATE_URL [NSString stringWithFormat:@"%@%@",BASE_URL,@"/seekout/seekoutCreate?sid="]
