//
//  TimerUtils.m
//  PsychicLoan
//
//  Created by admin on 2017/12/1.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "TimerUtils.h"

@implementation TimerUtils

+(RACDisposable*)startCountDown:(NSInteger)count timeInterval:(NSInteger)timeInterval countDownHander:(void (^)(NSInteger))countDownHander completeHander:(void (^)())completeHander{
    //定时任务，可以代替NSTimer,可以看到`RACScheduler`使用GCD实现的
    __block NSInteger lastCount = count;
    __block RACDisposable* timerHandler = [[RACSignal interval:timeInterval onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        lastCount --;
        countDownHander(lastCount);
        if(lastCount <= 0){//已经结束了
            completeHander();
            [timerHandler dispose];//结束计时
        }
    }];
    return timerHandler;
}

@end
