//
//  LoginViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/29.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoginViewModel.h"
#import "AuthCodeModel.h"

@implementation LoginViewModel

-(void)getAuthCode:(NSString *)telephone type:(AuthCodeType)type returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    NSDictionary* bodyData = @{@"phonenumber":telephone,@"type":@(type)};
    [NetRequestClass NetRequestPOSTWithRequestURL:LOGIN_AUTH_CODE_URL WithParameter:nil headers:nil body:GetBody(bodyData) WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if ([resultcode intValue] == 2) {//发送成功
             AuthCodeModel* authCodeModel = [AuthCodeModel yy_modelWithJSON:[returnValue valueForKey:@"data"]];
             returnBlock(authCodeModel);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

-(void)registerAccount:(NSString *)telephone password:(NSString*)password authCode:(NSString *)authCode authCodeBean:(AuthCodeModel *)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if(!authCodeBean){
        failureBlock(nil,@"请先获取验证码");//请求失败描述
        return;
    }
    NSDictionary* bodyData = @{@"phonenumber":telephone,@"type":@(AuthCodeTypeRegister),@"password":password,@"tamp":authCodeBean.tamp,@"hashcode":authCodeBean.hashcode,@"code":authCode,@"channel":@"appstore",@"platform":@"ios"};
    [NetRequestClass NetRequestPOSTWithRequestURL:LOGIN_VALIDATA_URL WithParameter:nil headers:nil body:GetBody(bodyData) WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if ([resultcode intValue] == 8) {//注册成功
             returnBlock(nil);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

-(void)updatePassword:(NSString *)telephone password:(NSString *)password authCode:(NSString *)authCode authCodeBean:(AuthCodeModel *)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if(!authCodeBean){
        failureBlock(nil,@"请先获取验证码");//请求失败描述
        return;
    }
    NSDictionary* bodyData = @{@"phonenumber":telephone,@"type":@(AuthCodeTypePassword),@"password":password,@"tamp":authCodeBean.tamp,@"hashcode":authCodeBean.hashcode,@"code":authCode,@"channel":@"appstore",@"platform":@"ios"};
    [NetRequestClass NetRequestPOSTWithRequestURL:LOGIN_VALIDATA_URL WithParameter:nil headers:nil body:GetBody(bodyData) WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if ([resultcode intValue] == 10) {//更新成功
             returnBlock(nil);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

-(void)loginWithAuthCode:(NSString *)telephone authCode:(NSString *)authCode authCodeBean:(AuthCodeModel *)authCodeBean returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if(!authCodeBean){
        failureBlock(nil,@"请先获取验证码");//请求失败描述
        return;
    }
    NSDictionary* bodyData = @{@"phonenumber":telephone,@"type":@(AuthCodeTypeNormal),@"tamp":authCodeBean.tamp,@"hashcode":authCodeBean.hashcode,@"code":authCode,@"channel":@"appstore",@"platform":@"ios"};
    [NetRequestClass NetRequestPOSTWithRequestURL:LOGIN_VALIDATA_URL WithParameter:nil headers:nil body:GetBody(bodyData) WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if ([resultcode intValue] == 4) {//验证码登录成功
             returnBlock(nil);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}


-(void)loginWithPassword:(NSString *)telephone password:(NSString *)password returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    NSDictionary* bodyData = @{@"phonenumber":telephone,@"password":password};
    [NetRequestClass NetRequestPOSTWithRequestURL:LOGIN_PASSWORD_URL WithParameter:nil headers:nil body:GetBody(bodyData) WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if ([resultcode intValue] == 13) {//密码登录成功
             returnBlock(nil);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}


@end
