//
//  DetailViewModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailViewModel : NSObject

-(void)getLoanDetailById:(long)loanId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
