//
//  HomeModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanModel.h"
#import "BannerModel.h"
#import "BaseModel.h"

@interface HomeModel : BaseModel

@property(nonatomic,retain)NSArray<BannerModel*>* banner;
@property(nonatomic,retain)NSArray<LoanModel*>* hotloan;
@property(nonatomic,retain)NSArray<LoanModel*>* recommend;
@property(nonatomic,retain)NSArray* btntext;

@end
