//
//  AuthCodeModel.h
//  PsychicLoan
//
//  Created by admin on 2017/11/29.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthCodeModel : NSObject

@property(nonatomic,copy)NSString* tamp;
@property(nonatomic,copy)NSString* hashcode;

@end
