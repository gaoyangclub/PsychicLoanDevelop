//
//  LoanViewModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanViewModel : NSObject

-(void)getLoansByType:(int)loanType returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
-(void)getLoansByFilter:(int)mintime maxtime:(int)maxtime search:(int)search minamount:(int)minamount maxamount:(int)maxamount returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
