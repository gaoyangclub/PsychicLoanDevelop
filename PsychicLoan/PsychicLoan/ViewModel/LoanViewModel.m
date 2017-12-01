//
//  LoanViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanViewModel.h"
#import "MarketModel.h"

@implementation LoanViewModel

-(void)getLoansByType:(int)loanType returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_TYPE_URL(loanType) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         MarketModel* marketModel = [MarketModel yy_modelWithJSON:returnValue];
         if (marketModel.resultcode > 0) {//请求成功
             returnBlock(marketModel.data);
         }else{
             failureBlock(nil,marketModel.msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

-(void)getLoansByFilter:(int)mintime maxtime:(int)maxtime search:(int)search minamount:(int)minamount maxamount:(int)maxamount returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_FILTER_URL(mintime, maxtime, search, minamount, maxamount) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         MarketModel* marketModel = [MarketModel yy_modelWithJSON:returnValue];
         if (marketModel.resultcode > 0) {//请求成功
             returnBlock(marketModel.data);
         }else{
             failureBlock(nil,marketModel.msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

@end
