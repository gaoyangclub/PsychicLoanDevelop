//
//  ASTextNode+Measure.h
//  PsychicLoan
//
//  Created by admin on 2018/1/8.
//  Copyright © 2018年 GaoYang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ASTextNode (Measure)

- (void)sizeToFit;

- (CGSize)sizeThatFits:(CGSize)size;

@end
