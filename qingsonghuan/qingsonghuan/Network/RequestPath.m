//
//  RequestPath.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RequestPath.h"

@implementation RequestPath
//注册页信息 ( 航空公司,子公司,职务,签证 )
+ (void)user_regNeedInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:API_USER_REGNEEDINFO success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)obj, code, mes);
        } else {
            failure(ErrorTypeReqestNone, mes);
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD hideHUDForView:view];
        failure(errorType, mes);
    }];
}
// 验证码接口
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
                [MBProgressHUD hideHUDForView:view];
            }
        } failure:^(ErrorType errorType, NSString *mes) {
            [MBProgressHUD showError:mes ToView:view];
        }];
    } else {
        [MBProgressHUD showError:@"请填写完整的手机号" ToView:view];
    }
}

//注册
+ (void)user_registerParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_REGISTER parameters:param success:success failure:failure];
}
//找回密码
+ (void)user_retrieveParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_RETRIEVE parameters:param success:success failure:failure];
}
@end
