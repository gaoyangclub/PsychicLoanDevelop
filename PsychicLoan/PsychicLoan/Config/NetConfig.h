//
//  NetConfig.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_URL_TEST @"http://47.100.15.41:8080"//测试环境
#define SERVER_URL_RELEASE @"https://www.psychicloan.com:8443"//生产环境

#define SERVER_DRIVER_URL SERVER_URL_RELEASE//[NetConfig getDriverNetUrl:NET_MODE]

#define HOME_POP_VIEW_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/home/getview")

#define USE_H5_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/home/useh5")
#define HOME_LOAN_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/home/gethome")
#define LOAN_TYPE_URL(type) ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanlist/getloanlist?type=",@(type))
#define LOAN_DETAIL_URL(loanid) ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loaninfo/getloanbyid?loanid=",@(loanid))
#define LOAN_FILTER_URL(mintime,maxtime,search,minamount,maxamount) ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanlist/getsearchlist?mintime=",@(mintime),@"&maxtime=",@(maxtime),@"&search=",@(search),@"&minamount=",@(minamount),@"&maxamount=",@(maxamount))

#define LOGIN_AUTH_CODE_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanuser/sendsms")

#define LOGIN_VALIDATA_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanuser/validataNum")
#define LOGIN_PASSWORD_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanuser/loginbypassword")



@interface NetConfig : NSObject

@end
