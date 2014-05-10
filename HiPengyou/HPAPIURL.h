//
//  HPAPIURL.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define PORT @":8001"
//#define FACE_PORT @":8002"
//#define BASE_URL @"http://quickycard.com"

#define PORT @":15730"
#define FACE_PORT @":15731"
#define BASE_URL @"http://timadidas.vicp.cc"



#define LOGIN_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/index/login"]
#define REGISTER_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/index/register"]
#define SEEKOUT_LIST_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/seekoutListForSlide?"]
#define SEEKOUT_CREATE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/seekoutCreate?"]
#define FACE_IMAGE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,FACE_PORT,@"/faceimage/"]
#define PERSONAL_SEEKOUT_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/seekout/personalseekoutList?"]
#define COMMENT_LIST_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/comment/commentwithlikeList?"]
#define CREATE_COMMENT_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/comment/commentwithvoiceCreate?"]
#define UPLOAD_FACE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/user/userFaceimageEdit?"]
#define MESSAGE_LIST_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/message/allmessageList?"]
#define SEND_MESSAGE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/message/messagewithvoiceCreate?"]
#define LIKE_CREATE_URL [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/like/likeCreate?"]
#define USER_INFO [NSString stringWithFormat:@"%@%@%@",BASE_URL,PORT,@"/user/userView?"]


