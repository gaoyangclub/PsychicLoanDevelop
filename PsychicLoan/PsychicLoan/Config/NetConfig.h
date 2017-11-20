//
//  NetConfig.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_URL_TEST @"http://47.100.15.41:8080"//测试环境

#define SERVER_DRIVER_URL SERVER_URL_TEST//[NetConfig getDriverNetUrl:NET_MODE]

#define HOME_LOAN_URL ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/home/gethome")
#define LOAN_TYPE_URL(type) ConcatStrings(SERVER_DRIVER_URL,@"/loan-api/loanlist/getloanlist?type=",@(type))


@interface NetConfig : NSObject

@end