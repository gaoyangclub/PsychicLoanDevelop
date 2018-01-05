//
//  MobClickEventManager.h
//  PsychicLoan
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

//#define MOBCLICK_EVENT_HOME_LOAD @"";
#define MOBCLICK_EVENT_HOT @"PL0005" //热门推荐点击
#define MOBCLICK_EVENT_RECOMMEND @"PL0006" //编辑推荐点击
#define MOBCLICK_EVENT_FAST @"PL0007"
#define MOBCLICK_EVENT_MARKET @"PL0008_01"

#define MOBCLICK_EVENT_DETAIL_CUSTOMER @"PL0010_02"
#define MOBCLICK_EVENT_USER_CUSTOMER @"PL0011_01"

#import <Foundation/Foundation.h>

@interface MobClickEventManager : NSObject

+(void)homeViewControllerDidLoad;

+(void)homeBannerClick:(long)loanid;

+(void)homeFastClick:(NSInteger)loanType;

+(void)homePopWillShow;

+(void)homePopClick:(long)loanid;

//+(void)loanTypeHotClick:(long)loanid isLink:(BOOL)isLink;
//+(void)loanTypeRecommendClick:(long)loanid isLink:(BOOL)isLink;
//+(void)loanTypeFastClick:(long)loanid isLink:(BOOL)isLink;
//+(void)loanMarketFilterClick:(long)loanid isLink:(BOOL)isLink;

+(void)loanTypeClickByEvent:(NSString*)event loanid:(long)loanid isLink:(BOOL)isLink;

//amount:min-max search:search time:min-max
+(void)loanMarketFilterSelected:(NSString*)amount search:(NSString*)search time:(NSString*)time;

+(void)loanMarketControllerDidLoad;

+(void)webViewControllerDidLoad:(long)loanid;

+(void)webViewAlertClick:(long)loanid isCancel:(BOOL)isCancel;

+(void)detailViewControllerDidLoad:(long)loanid;

+(void)detailSubmitClick:(long)loanid;

+(void)detailCustomerClick;

+(void)userViewControllerDidLoad;
+(void)userFeedbackClick;
+(void)userCustomerClick;
+(void)userLogoutClick;

+(void)loginViewControllerDidLoad;

+(void)registerViewControllerDidLoad;

+(void)loginComplete;
+(void)registerComplete;

@end
