//
//  MarketModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "BaseModel.h"
#import "LoanModel.h"

@interface MarketModel : BaseModel

@property(nonatomic,retain)NSArray<LoanModel*>* data;

@end
