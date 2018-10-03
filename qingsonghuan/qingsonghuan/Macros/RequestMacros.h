//
//  RequestMacros.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef RequestMacros_h
#define RequestMacros_h

#define BASE_URL                @"http://47.75.167.95"

//1.注册页信息 ( 航空公司,子公司,职务,签证 )
#define API_USER_REGNEEDINFO           [NSString stringWithFormat:@"%@/user/regNeedInfo",BASE_URL]
//2.发送手机验证码
#define API_USER_SENDCODE              [NSString stringWithFormat:@"%@/user/sendCode",BASE_URL]
//3.注册
#define API_USER_REGISTER              [NSString stringWithFormat:@"%@/user/register",BASE_URL]
//4.找回密码
#define API_USER_RETRIEVE              [NSString stringWithFormat:@"%@/user/retrieve",BASE_URL]
//5.登录
#define API_USER_LOGIN                 [NSString stringWithFormat:@"%@/user/login",BASE_URL]
//6.获取航段列表
#define API_FLIGHT_GETLISTFLIGHT       [NSString stringWithFormat:@"%@/flight/getListFlight",BASE_URL]
//7.添加航班信息
#define API_FLIGHT_ADDLINE             [NSString stringWithFormat:@"%@/flight/addLine",BASE_URL]
//8.用户站内信列表
#define API_LETTER_MESLIST             [NSString stringWithFormat:@"%@/letter/mesList",BASE_URL]
//9.站内信删除
#define API_LETTER_MESDEL              [NSString stringWithFormat:@"%@/letter/mesDel",BASE_URL]
//10.读站内信
#define API_LETTER_MESSEE              [NSString stringWithFormat:@"%@/letter/mesSee",BASE_URL]
//11.当前用户未读信息数量
#define API_LETTER_ISMES               [NSString stringWithFormat:@"%@/letter/isMes",BASE_URL]
//12.修改航班信息
#define API_FLIGHT_EDITFLIGHT          [NSString stringWithFormat:@"%@/flight/editFlight",BASE_URL]
//13.删除一条航班信息
#define API_FLIGHT_DELFLIGHT           [NSString stringWithFormat:@"%@/flight/delFlight",BASE_URL]
//14.获取当前用户个人信息
#define API_USER_GETUSERINFO           [NSString stringWithFormat:@"%@/user/getUserInfo",BASE_URL]
//15.个人信息修改
#define API_USER_EDITUSERINFO          [NSString stringWithFormat:@"%@/user/editUserInfo",BASE_URL]
//16.发送站内信
#define API_LETTER_MESSEND             [NSString stringWithFormat:@"%@/letter/mesSend",BASE_URL]
//17.添加建议
#define API_ADVICE_ADDADVIC            [NSString stringWithFormat:@"%@/advice/addAdvice",BASE_URL]



#endif /* RequestMacros_h */
