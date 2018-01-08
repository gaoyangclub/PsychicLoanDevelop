//
//  ASTextNode+Measure.m
//  PsychicLoan
//
//  Created by admin on 2018/1/8.
//  Copyright © 2018年 GaoYang. All rights reserved.
//

#import "ASTextNode+Measure.h"

@implementation ASTextNode (Measure)

-(void)sizeToFit{
    CGRect frame = self.frame;
    frame.size = [self layoutThatFits:ASSizeRangeMake(CGSizeZero, CGSizeMake(FLT_MAX, FLT_MAX))].size;
    self.frame = frame;
}

-(CGSize)sizeThatFits:(CGSize)size{
    return [self layoutThatFits:ASSizeRangeMake(CGSizeZero, size)].size;
}

@end
