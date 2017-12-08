//
//  MobClickEventManager.m
//  PsychicLoan
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "MobClickEventManager.h"
#import "UMMobClick/MobClick.h"
#import "UserDefaultsUtils.h"

@implementation MobClickEventManager

+(void)homeViewControllerDidLoad{
    [MobClick event:@"PL0001"];
}

+(void)homeBannerClick:(long)loanid{
    [MobClick event:@"PL0002" attributes:@{@"loanid":@(loanid)}];
}

+(void)homeFastClick:(NSInteger)loanType{
    NSString* classification;
    switch (loanType) {
        case LOAN_TYPE_NEW:
            classification = @"left";
            break;
        case LOAN_TYPE_FAST:
            classification = @"mid";
            break;
        case LOAN_TYPE_PASS:
            classification = @"right";
            break;
    }
    [MobClick event:@"PL0003" attributes:@{@"classification":classification}];
}

+(void)homePopWillShow{
    [MobClick event:@"PL0004"];
}

+(void)homePopClick:(long)loanid{
    [MobClick event:@"PL0004_01" attributes:@{@"loanid":@(loanid)}];
}

//+(void)loanTypeFastClick:(long)loanid isLink:(BOOL)isLink{
//    [MobClickEventManager loanTypeClickByEvent:@"" loanid:loanid isLink:isLink];
//}
//
//+(void)loanTypeHotClick:(long)loanid isLink:(BOOL)isLink{
//    [MobClickEventManager loanTypeClickByEvent:@"" loanid:loanid isLink:isLink];
//}
//
//+(void)loanTypeRecommendClick:(long)loanid isLink:(BOOL)isLink{
//    [MobClickEventManager loanTypeClickByEvent:@"" loanid:loanid isLink:isLink];
//}
//
//+(void)loanMarketFilterClick:(long)loanid isLink:(BOOL)isLink{
//    [MobClickEventManager loanTypeClickByEvent:@"" loanid:loanid isLink:isLink];
//}

+(void)loanTypeClickByEvent:(NSString*)event loanid:(long)loanid isLink:(BOOL)isLink{
    NSString* loanidStr;
    if (isLink) {
        loanidStr = ConcatStrings(@"",@(loanid),[MobClickEventManager userIsLogin] ? @"_02" : @"_03");
    }else{
        loanidStr = ConcatStrings(@"",@(loanid),@"_01");
    }
    [MobClick event:event attributes:@{@"loanid":loanidStr}];
}

+(void)loanMarketControllerDidLoad{
    [MobClick event:@"PL0008"];
}

+(void)loanMarketFilterSelected:(NSString*)amount search:(NSString*)search time:(NSString*)time{
    [MobClick event:@"PL0008_02" attributes:@{@"amount":amount,@"search":search,@"time":time}];
}

+(void)webViewControllerDidLoad:(long)loanid{
    [MobClick event:@"PL0009" attributes:@{@"loanid":@(loanid)}];
}

+(void)webViewAlertClick:(long)loanid isCancel:(BOOL)isCancel{
    [MobClick event:@"PL0009_01" attributes:@{@"loanid":ConcatStrings(@"",@(loanid),isCancel ? @"_02" : @"_01")}];
}

+(void)detailViewControllerDidLoad:(long)loanid{
    [MobClick event:@"PL0010" attributes:@{@"loanid":@(loanid)}];
}

+(void)detailSubmitClick:(long)loanid{
    [MobClick event:@"PL0010_01" attributes:@{@"loanid":ConcatStrings(@"",@(loanid),[MobClickEventManager userIsLogin] ? @"_02" : @"_03")}];
}

+(void)detailCustomerClick{
    [MobClick event:MOBCLICK_EVENT_DETAIL_CUSTOMER];
}

+(void)userViewControllerDidLoad{
    [MobClick event:@"PL0011"];
}

+(void)userCustomerClick{
    [MobClick event:MOBCLICK_EVENT_USER_CUSTOMER];
}

+(void)userFeedbackClick{
    [MobClick event:@"PL0011_03"];
}

+(void)userLogoutClick{
    [MobClick event:@"PL0011_04"];
}

+(void)loginViewControllerDidLoad{
    [MobClick event:@"PL0012"];
}

+(void)registerViewControllerDidLoad{
    [MobClick event:@"PL0013"];
}

+(void)loginComplete{
    [MobClick event:@"PL0012_01"];
}

+(void)registerComplete{
    [MobClick event:@"PL0013_01"];
}

+(BOOL)userIsLogin{
    if ([UserDefaultsUtils getObject:PHONE_KEY]) {
        return YES;
    }
    return NO;
}

@end
