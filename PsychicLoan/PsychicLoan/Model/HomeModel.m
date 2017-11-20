//
//  HomeModel.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"hotloan":[LoanModel class],@"recommend":[LoanModel class],@"banner":[BannerModel class]};
}


@end
