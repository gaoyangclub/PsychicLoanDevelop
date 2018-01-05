//
//  LoanViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanViewModel.h"
#import "LoanModel.h"

@implementation LoanViewModel

-(void)getLoansByType:(int)loanType returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_TYPE_URL(loanType) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
//         MarketModel* marketModel = [MarketModel yy_modelWithJSON:returnValue];
//         [AuthCodeModel yy_modelWithJSON:[returnValue valueForKey:@"data"]];
         if (resultcode > 0) {//请求成功
             NSArray<LoanModel*>* data = [NSArray yy_modelArrayWithClass:[LoanModel class] json:[returnValue valueForKey:@"data"]];
             returnBlock(data);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

-(void)getLoansByFilter:(int)mintime maxtime:(int)maxtime search:(int)search minamount:(int)minamount maxamount:(int)maxamount returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_FILTER_URL(mintime, maxtime, search, minamount, maxamount) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
//         MarketModel* marketModel = [MarketModel yy_modelWithJSON:returnValue];
         if (resultcode > 0) {//请求成功
             NSArray<LoanModel*>* data = [NSArray yy_modelArrayWithClass:[LoanModel class] json:[returnValue valueForKey:@"data"]];
             returnBlock(data);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

@end
