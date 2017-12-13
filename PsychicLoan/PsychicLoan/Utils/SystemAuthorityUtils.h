//
//  SystemAuthorityUtils.h
//  PsychicLoan
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemAuthorityUtils : NSObject

+(void)checkNetWorkReachability:(void(^)())nextHandler;

@end
