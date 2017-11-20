//
//  LoanDetailModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanModel.h"

@interface LoanDetailModel : LoanModel

@property(nonatomic,copy)NSString* passrate;//通过率
@property(nonatomic,assign)long mintime;//最小期数
@property(nonatomic,assign)long maxtime;//最小期数

@property(nonatomic,assign)long minamount;//最小金额
@property(nonatomic,copy)NSString* rate;//日利率
@property(nonatomic,assign)double time;//放款时间
@property(nonatomic,copy)NSString* information;//申请材料

@end
