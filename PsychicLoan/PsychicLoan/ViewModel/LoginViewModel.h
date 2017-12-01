//
//  LoginViewModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/29.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthCodeModel.h"

typedef NS_ENUM(NSInteger,AuthCodeType){
    AuthCodeTypeRegister = 0,//注册
    AuthCodeTypePassword = 1,//修改密码
    AuthCodeTypeNormal = 2//验证码
};
@interface LoginViewModel : NSObject

-(void)getAuthCode:(NSString*)telephone type:(AuthCodeType)type returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)registerAccount:(NSString*)telephone password:(NSString*)password authCode:(NSString*)authCode authCodeBean:(AuthCodeModel*)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)updatePassword:(NSString*)telephone password:(NSString*)password authCode:(NSString*)authCode authCodeBean:(AuthCodeModel*)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)loginWithAuthCode:(NSString*)telephone authCode:(NSString*)authCode authCodeBean:(AuthCodeModel*)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)loginWithPassword:(NSString*)telephone password:(NSString*)password returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
