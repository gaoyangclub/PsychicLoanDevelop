//
//  LoanModel.h
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanModel : NSObject

@property(nonatomic,assign)long loanid;
@property(nonatomic,copy)NSString* loanname;
@property(nonatomic,copy)NSString* loanlogo;
@property(nonatomic,assign)long maxamount;//最大金额
@property(nonatomic,copy)NSString* loandes;//推荐语
@property(nonatomic,copy)NSString* loanurl;//贷款H5页面链接

@end
