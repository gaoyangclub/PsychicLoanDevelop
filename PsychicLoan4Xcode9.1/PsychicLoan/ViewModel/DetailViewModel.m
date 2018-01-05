//
//  DetailViewModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailViewModel.h"
#import "LoanDetailModel.h"

@implementation DetailViewModel

-(void)getLoanDetailById:(long)loanId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [NetRequestClass NetRequestGETWithRequestURL:LOAN_DETAIL_URL(loanId) WithParameter:nil headers:nil WithReturnValeuBlock:
     ^(id returnValue) {
         NSString* resultcode = [returnValue valueForKey:@"resultcode"];
//         DetailModel* detailModel = [DetailModel yy_modelWithJSON:returnValue];
         NSObject* data = [returnValue valueForKey:@"data"];
         if (resultcode > 0 && data) {//请求成功
             LoanDetailModel* loanModel = [LoanDetailModel yy_modelWithJSON:data];
             returnBlock(loanModel);
         }else{
             NSString* msg = [returnValue valueForKey:@"msg"];
             failureBlock(nil,msg);//请求失败描述
         }
     } WithFailureBlock:failureBlock];
}

@end
