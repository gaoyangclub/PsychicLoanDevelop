//
//  MeasureUnitConvert.h
//  PsychicLoan
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeasureUnitConvert : NSObject

//time基础单位为分
+(NSString*)timeConvert:(double)time;
//amount基础单位为元
+(NSString*)amountConvert:(long)amount;

@end
