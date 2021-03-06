//
//  RequestPath.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RequestPath.h"
#import "RegNeedInfoModel.h"


@implementation RequestPath
//TODO: APP接口
//1.注册页信息 ( 航空公司,子公司,职务,签证 )
+ (void)user_regNeedInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    if ([RegNeedInfoModel checkRegData]) {
        //本身有数据，不再请求
        success(@{},1,@"请求成功");
        return;
    }
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_REGNEEDINFO success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            [[RegNeedInfoModel sharedInstance]reloadWithDic:obj];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:API_REUQEST_FAILED ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//2.验证码接口
+ (void)user_sendCodeView:(UIView *)view
                    phone:(NSString *)phone
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [view endEditing:YES];
    if ([NSString validatePhoneNumber:phone]) {
        [MBProgressHUD showToView:view];
        [XYNetworking postWithUrlString:API_USER_SENDCODE parameters:@{@"phone":phone} success:^(id obj, NSInteger code, NSString *mes) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [MBProgressHUD showSuccess:@"手机验证码发送成功" ToView:view];
                success((NSDictionary *)obj, code, mes);
            } else {
                [MBProgressHUD showError:API_REUQEST_FAILED ToView:view];
                failure(ErrorTypeReqestNone, mes);
            }
        } failure:^(ErrorType errorType, NSString *mes) {
            [MBProgressHUD showError:mes ToView:view];
            failure(errorType,mes);
        }];
    } else {
        [MBProgressHUD showError:@"请填写完整的手机号" ToView:view];
    }
}

//3.注册
+ (void)user_registerView:(UIView *)view
                    Param:(NSDictionary *)param
                  success:(void (^)(id obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking  postWithUrlString:API_USER_REGISTER parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            [[RegNeedInfoModel sharedInstance]reloadWithDic:obj];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//4.找回密码
+ (void)user_retrieveView:(UIView *)view
                    Param:(NSDictionary *)param
                  success:(void (^)(id obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_RETRIEVE parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD hideHUDForView:view];
        success(obj,code,mes);
    } failure:^(ErrorType errorType, NSString *mes) {
        failure(ErrorTypeReqestNone, mes);
        [MBProgressHUD showError:mes ToView:view];
    }];
}
//5.登录
+ (void)user_loginView:(UIView *)view
                 param:(NSDictionary *)param
               success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
               failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_LOGIN parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//6.获取航段列表
+ (void)flight_getListFlightParam:(NSDictionary *)param
                          success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                          failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_FLIGHT_GETLISTFLIGHT parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:API_REUQEST_FAILED];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes];
        failure(errorType, mes);
    }];
}
//7.添加航班信息
+ (void)flight_addlineView:(UIView *)view
                     param:(NSDictionary *)param
                   success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_FLIGHT_ADDLINE parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//8.用户站内信列表
+ (void)letter_mesListParam:(NSDictionary *)param
                    success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                    failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_LETTER_MESLIST parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes];
        failure(errorType, mes);
    }];
}

//9.站内信删除
+ (void)letter_mesdelView:(UIView *)view
                    param:(NSDictionary *)param
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_LETTER_MESDEL parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//10.读站内信
+ (void)letter_messeeView:(UIView *)view
                    param:(NSDictionary *)param
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_LETTER_MESSEE parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//11.当前用户未读信息数量
+ (void)letter_isMessuccess:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                    failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_LETTER_ISMES success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        failure(errorType, mes);
    }];
}
//12.修改航班信息
+ (void)flight_editFlightView:(UIView *)view
                        param:(NSDictionary *)param
                      success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                      failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_FLIGHT_EDITFLIGHT parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes ToView:view];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//13.删除一条航班信息
+ (void)flight_delFlightView:(UIView *)view
                       param:(NSDictionary *)param
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_FLIGHT_DELFLIGHT parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD hideHUDForView:view];
        success((NSDictionary *)obj, code, mes);
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//14.获取当前用户个人信息
+ (void)user_getUserInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_GETUSERINFO success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//15.个人信息修改
+ (void)user_editUserInfoView:(UIView *)view
                        param:(NSDictionary *)param
                      success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                      failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_EDITUSERINFO parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//16.发送站内信
+ (void)letter_mesSendView:(UIView *)view
                     param:(NSDictionary *)param
                   success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_LETTER_MESSEND parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//17.添加建议
+ (void)advice_addAdviceView:(UIView *)view
                       param:(NSDictionary *)param
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_ADVICE_ADDADVIC parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//18.获取公告列表
+ (void)announcement_getListParam:(NSDictionary *)param
                          success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                          failure:(void (^)(ErrorType errorType, NSString *mes))failure{
    [XYNetworking postWithUrlString:API_ANNOUNCEMENT_LIST parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes];
        failure(errorType, mes);
    }];
}
//20.获取版本
+ (void)data_getcfgParam:(NSDictionary *)param
                 success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                 failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_DATA_GETCFG parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        failure(errorType, mes);
    }];
}



//TODO: 后台接口
/**
 1.
 ①、注册人数统计
 ②、航班统计
 ③、站内信统计
 */
+ (void)statistics_StaView:(UIView *)view
                       url:(NSString *)url
                     param:(NSDictionary *)param
                   success:(void (^)(NSArray *obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:url parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSArray *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//2.根据设备统计人数
+ (void)statistics_equipmentStaView:(UIView *)view
                              param:(NSDictionary *)param
                            success:(void (^)(NSArray *obj, NSInteger code, NSString *mes))success
                            failure:(void (^)(ErrorType errorType, NSString *mes))failure; {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_STATISTICS_EQUIPMENTSTA parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSArray *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}
//3.建议列表
+ (void)statistics_getAdviceListParam:(NSDictionary *)param
                             success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                             failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_STATISTICS_GETADVICELIST parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes];
        failure(errorType, mes);
    }];
}
//4.用户列表
+ (void)statistics_getUserListParam:(NSDictionary *)param
                            success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                            failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_STATISTICS_GETUSERLIST parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            [MBProgressHUD showError:mes];
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes];
        failure(errorType, mes);
    }];
}
//5.删除，注销，取消注销接口(0正常，1禁用，2删除)
+ (void)statistics_editUserStatusView:(UIView *)view
                                param:(NSDictionary *)param
                              success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                              failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_STATISTICS_EDITUSERSTATUS parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

//8.添加公告
+ (void)statistics_addAnnouncementView:(UIView *)view
                                 param:(NSDictionary *)param
                               success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                               failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_STATISTICS_ADDANNOUNCE parameters:param success:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [MBProgressHUD hideHUDForView:view];
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
            [MBProgressHUD showError:mes ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes);
    }];
}

@end
