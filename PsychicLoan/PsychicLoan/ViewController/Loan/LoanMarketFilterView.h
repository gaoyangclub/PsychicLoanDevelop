//
//  LoanMarketFilterView.h
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSDropDownMenu.h"

@class LoanMarketFilterView;
@protocol LoanMarketFilterDelegate <NSObject>
@optional
-(void)loanFilterSelected:(LoanMarketFilterView*)view;//选中某个条件
@end

@interface LoanMarketFilterView : JSDropDownMenu

@property(nonatomic,assign,readonly)int mintime;
@property(nonatomic,assign,readonly)int maxtime;
@property(nonatomic,assign,readonly)int search;
@property(nonatomic,assign,readonly)int minamount;
@property(nonatomic,assign,readonly)int maxamount;

@property (nonatomic, weak) id<LoanMarketFilterDelegate> filterDelegate;

@end
