//
//  Config.h
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//
#import "LocalBundleManager.h"
#import "MathUtils.h"

#define COLOR_BLACK_ORIGINAL rgba(95,95,95,1)
#define COLOR_NAVI_TITLE COLOR_BLACK_ORIGINAL

#define COLOR_PRIMARY FlatMint//FlatSkyBlue//COLOR_YI_WAN_CHENG//rgba(23,182,46,1)//[Config getPrimaryColor]
#define COLOR_ACCENT rgb(120,196,112)

#define COLOR_BACKGROUND FlatWhite//rgba(226,226,226,1)
#define COLOR_LINE rgba(218,218,218,1)
//#define COLOR_YI_WAN_CHENG FlatGrayDark//COLOR_PRIMARY //rgb(67,152,216)//rgba(21,178,168,1)
//#define COLOR_DAI_WAN_CHENG COLOR_PRIMARY//FlatWatermelon//[UIColor flatSandColorDark]//rgb(250,83,44)//rgba(240,129,69,1)
#define LINE_WIDTH 0.5

#define APPLICATION_NAME [LocalBundleManager getAppName]//@"百世通"
#define APPLICATION_NAME_EN @"Psychic Loan"

#define ICON_FONT_NAME @"iconfont"

#define DEBUG_MODE YES

//#define PER_PAGE_COUNT 20 //每一页数据个数

#define TABBAR_TITLE_HOME @"主页"
#define TABBAR_TITLE_LOAN @"贷款"
#define TABBAR_TITLE_USER @"我的"

#define NAVIGATION_TITLE_HOME @"主页"//APPLICATION_NAME
#define NAVIGATION_TITLE_LOAN @"贷款超市"
#define NAVIGATION_TITLE_USER @"我的"

#define NAVIGATION_TITLE_MESSAGE @"消息提醒"
#define NAVIGATION_TITLE_VERSION @"版本信息"
#define NAVIGATION_TITLE_ADMIN @"管理员大帝"

#define ICON_FAN_HUI @"\U0000e730"//@"\U0000e614"
#define ICON_SHE_ZHI @"\U0000e628"

#define ICON_EMPTY_WAN_CHENG @"\U0000e60c"
#define ICON_EMPTY_WANG_LUO @"\U0000e68c"//@"\U0000e62d"
#define ICON_EMPTY_NO_DATA @"\U0000e601"

#define SYSTEM_SCALE [UIScreen mainScreen].scale
#define SCREEN_WIDTH [UIScreen mainScreen].nativeBounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].nativeBounds.size.height

#define IPHONE_5S_WIDTH 640.0
#define IPHONE_6_WIDTH 750.0

//以iphone6为基础 坐标都以iphone6为基准 进行代码的适配
#define rpx(px) px * SCREEN_WIDTH / SYSTEM_SCALE / 320.0// IPHONE_5S_WIDTH

#define HOME_BANNER_CELL_HEIGHT rpx(180)
#define HOME_FAST_CELL_HEIGHT rpx(50)


@interface Config : NSObject

+(NSString*)getVersionDescription;

@end
