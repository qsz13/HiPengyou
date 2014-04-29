//
//  HPAPIURL.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PORT @":8001"
#define FACE_PORT @":8002"
#define BASE_URL @"http://quickycard.com"
#define LOGIN_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/index/login"]
#define REGISTER_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/index/register"]
#define SEEKOUT_LIST_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/seekoutListForSlide?"]
#define SEEKOUT_CREATE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/seekoutCreate?"]
#define FACE_IMAGE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,FACE_PORT,@"/faceimage/"]
#define PERSONAL_SEEKOUT_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/personalseekoutList?"]
#define COMMENT_LIST_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/comment/commentList?"]
