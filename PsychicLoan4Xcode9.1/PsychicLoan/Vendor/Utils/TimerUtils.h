//
//  TimerUtils.h
//  PsychicLoan
//
//  Created by admin on 2017/12/1.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerUtils : NSObject

+(RACDisposable*)startCountDown:(NSInteger)count timeInterval:(NSInteger)timeInterval countDownHander:(void(^)(NSInteger))countDownHander completeHander:(void(^)())completeHander;

@end
