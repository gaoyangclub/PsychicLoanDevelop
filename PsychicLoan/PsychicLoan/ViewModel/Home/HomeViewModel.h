//
//  HomeViewModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

-(void)getHomeLoans:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
