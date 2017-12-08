//
//  MeasureUnitConvert.m
//  PsychicLoan
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "MeasureUnitConvert.h"

@implementation MeasureUnitConvert

+(NSString *)timeConvert:(double)time{
    if (time >= 60) {
        double value = time / 60.;
        return [NSString stringWithFormat:@"%g小时",value];
    }
    return [NSString stringWithFormat:@"%g分钟",time];
}

+(NSString*)amountConvert:(long)amount{
    if (amount >= 10000) {
        return [NSString stringWithFormat:@"%ld万",amount / 10000];
    }
    return [NSString stringWithFormat:@"%ld元",amount];
}

@end
