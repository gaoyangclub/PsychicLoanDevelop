//
//  HomeViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeModel.h"

@implementation HomeViewModel

-(void)getHomeLoans:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:HOME_LOAN_URL WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         HomeModel* homeModel = [HomeModel yy_modelWithJSON:returnValue];
         if (homeModel.resultcode > 0) {//请求成功
             returnBlock(homeModel);
         }else{
             failureBlock(nil,homeModel.msg);//请求失败描述
         }
    } WithFailureBlock:failureBlock];
//    [NetRequestClass NetRequestPOSTWithRequestURL:PGY_VERSION_GROUP_URL WithParameter:@{@"aId":PGY_APPID,@"_api_key":PGY_APIKEY} headers:nil WithReturnValeuBlock:returnBlock WithFailureBlock:nil];
}

-(void)getHomePopView:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:HOME_POP_VIEW_URL WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
         if (resultcode > 0) {//请求成功
             BannerModel* bannerModel = [BannerModel yy_modelWithJSON:[returnValue valueForKey:@"data"]];
             returnBlock(bannerModel);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

@end
