//
//  DetailViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailViewModel.h"
#import "LoanDetailModel.h"
#import "DetailModel.h"

@implementation DetailViewModel

-(void)getLoanDetailById:(long)loanId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_DETAIL_URL(loanId) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         DetailModel* detailModel = [DetailModel yy_modelWithJSON:returnValue];
         if (detailModel.resultcode > 0 && detailModel.data) {//请求成功
             returnBlock(detailModel.data);
         }else{
             failureBlock(nil,detailModel.msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

@end
