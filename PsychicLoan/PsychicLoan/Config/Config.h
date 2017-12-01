//
//  Config.h
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//
#import "NetConfig.h"
#import "LocalBundleManager.h"
#import "MathUtils.h"

#define COLOR_BACKGROUND rgb(243,243,243)//FlatWhite
#define COLOR_LINE rgb(218,218,218)
//#define COLOR_YI_WAN_CHENG FlatGrayDark//COLOR_PRIMARY //rgb(67,152,216)//rgba(21,178,168,1)
//#define COLOR_DAI_WAN_CHENG COLOR_PRIMARY//FlatWatermelon//[UIColor flatSandColorDark]//rgb(250,83,44)//rgba(240,129,69,1)
#define LINE_WIDTH rpx(0.5)

#define COLOR_TEXT_PRIMARY FlatBlack
#define COLOR_TEXT_SECONDARY rgb(95,95,95)
#define COLOR_TEXT_THIRD COLOR_LINE

#define SIZE_TEXT_LARGE rpx(14)
#define SIZE_TEXT_PRIMARY rpx(12)
#define SIZE_TEXT_SECONDARY rpx(10)
#define SIZE_NAVI_TITLE rpx(16)

//#define COLOR_BLACK_ORIGINAL rgba(95,95,95,1)
#define COLOR_NAVI_TITLE [UIColor whiteColor]//COLOR_TEXT_SECONDARY

#define COLOR_PRIMARY rgb(58,155,233)//FlatSkyBlue//rgb(23,182,46)//FlatMint//COLOR_YI_WAN_CHENG//rgba(23,182,46,1)//[Config getPrimaryColor]
#define COLOR_ACCENT rgb(120,196,112)

#define COLOR_NOTICE_BACK rgb(108,179,233)

#define APPLICATION_NAME [LocalBundleManager getAppName]//@"百世通"
#define APPLICATION_NAME_EN @"Psychic Loan"

#define ICON_FONT_NAME @"iconfont"

#define DEBUG_MODE YES

#define AUTH_CODE_LENGTH 6

#define MAX_TIMER_COUNT_DOWN 30

//#define PER_PAGE_COUNT 20 //每一页数据个数

#define TABBAR_TITLE_HOME @"主页"
#define TABBAR_TITLE_LOAN @"贷款"
#define TABBAR_TITLE_USER @"我的"

#define NAVIGATION_TITLE_HOME @"主页"//APPLICATION_NAME
#define NAVIGATION_TITLE_LOAN @"贷款超市"
#define NAVIGATION_TITLE_USER @"我的"
#define NAVIGATION_TITLE_WEB @"注册"

#define NAVIGATION_TITLE_LOGIN @"登录"
#define NAVIGATION_TITLE_REGISTER @"注册"

#define NAVIGATION_TITLE_MESSAGE @"消息提醒"
#define NAVIGATION_TITLE_VERSION @"版本信息"
#define NAVIGATION_TITLE_ADMIN @"管理员大帝"

#define HOME_MOER_BUTTON_NAME @"查看更多贷款►"
#define HOME_MOER_TIPS @"合理贷款，让生活过得宽裕些"

#define LOAN_TYPE_PAGE_NOTICE_TEXT @"公告:审核放水，要借速度"
#define LOAN_MARKET_PAGE_NOTICE_TEXT @"公告:多多益善"

#define CUSTOMER_SERVICE_PUBLIC_TEXT @"牛逼的号" //客服公众号



#define SYSTEM_SCALE [UIScreen mainScreen].scale
#define SCREEN_WIDTH [UIScreen mainScreen].nativeBounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].nativeBounds.size.height

#define IPHONE_5S_WIDTH 640.0
#define IPHONE_6_WIDTH 750.0

//以iphone6为基础 坐标都以iphone6为基准 进行代码的适配
#define rpx(px) px * SCREEN_WIDTH / SYSTEM_SCALE / 320.0// IPHONE_5S_WIDTH

#define HOME_BANNER_CELL_HEIGHT rpx(180)
#define HOME_FAST_CELL_HEIGHT rpx(80)
#define HOME_LOAN_NORMAL_CELL_HEIGHT rpx(70)
#define LOAN_SECTION_HEIGHT rpx(30)
#define HOME_MORE_TIPS_CELL_HEIGHT rpx(80)

#define DETAIL_LOGO_CELL_HEIGHT rpx(100)
#define DETAIL_BASIC_CELL_HEIGHT rpx(50)
//#define DETAIL_VIEW_SECTION_HEIGHT rpx(30)
#define CUSTOM_SERVICE_HEIGHT rpx(50)

#define NOTICE_BACK_HEIGHT rpx(30)

//1为左侧按钮，2为中间按钮，3为右侧按钮，4为热门贷款，5为编辑推荐
#define LOAN_TYPE_HOT 4 //热门贷款
#define LOAN_TYPE_RECOMMEND 5 //推荐
#define LOAN_TYPE_NEW 1 //新品专区
#define LOAN_TYPE_FAST 2 //极速借钱
#define LOAN_TYPE_PASS 3 //高通过率

#define ICON_FAN_HUI @"\U0000e60f"//@"\U0000e614"
//#define ICON_SHE_ZHI @"\U0000e628"

#define ICON_EMPTY_WAN_CHENG @"\U0000e60c"
#define ICON_EMPTY_WANG_LUO @"\U0000e68c"//@"\U0000e62d"
#define ICON_EMPTY_NO_DATA @"\U0000e601"

#define ICON_SHOU_YE @"\U0000e617"
#define ICON_SHOU_YE_SELECTED @"\U0000e607"
#define ICON_DAI_KUAN @"\U0000e619"
#define ICON_DAI_KUAN_SELECTED @"\U0000e605"
//#define ICON_XIAO_XI @"\U0000e6c8"
//#define ICON_XIAO_XI_SELECTED @"\U0000e853"
#define ICON_WO_DE @"\U0000e618"
#define ICON_WO_DE_SELECTED @"\U0000e606"

#define ICON_XIN_PIN_ZHUAN_QU @"\U0000e601"
#define ICON_JI_SU_JIE_QIAN @"\U0000e604"
#define ICON_GAO_TONG_GUO_LV @"\U0000e603"

#define ICON_LIAN_XI_KE_FU @"\U0000e60b"
#define ICON_WEN_TI_FAN_KUI @"\U0000e60a"
#define ICON_GUAN_YU_WO_MEN @"\U0000e60d"

#define ICON_YONG_HU @"\U0000e61b"
#define ICON_YAN_ZHENG_MA @"\U0000e61a"

#define ICON_GONG_GAO @"\U0000e608"
#define ICON_FU_ZHI @"\U0000e611"
#define ICON_DA_GOU @"\U0000e61c"

#define EVENT_LOGIN_COMPLETE @"EVENT_LOGIN_COMPLETE"
#define EVENT_LOGOUT @"EVENT_LOGOUT"

#define USER_KEY @"user_key"
#define PHONE_KEY @"phone_key"

@interface Config : NSObject

+(NSString*)getLoanTypeNameByCode:(int)code;


+(NSString*)getVersionDescription;




@end
