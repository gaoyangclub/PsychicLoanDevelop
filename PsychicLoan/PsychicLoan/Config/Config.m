//
//  Config.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "Config.h"

static NSString* officialAccounts = @"牛逼的公众号";//客服公众号
static NSString* wechat = @"牛逼的微信号";//客服微信

@implementation Config

+(void)setOfficialAccounts:(NSString *)value{
    officialAccounts = value;
}

+(void)setWechat:(NSString *)value{
    wechat = value;
}

+(NSString *)getOfficialAccounts{
    return officialAccounts;
}

+(NSString *)getWechat{
    return wechat;
}

+(NSString *)getLoanTypeNameByCode:(int)code{
    switch (code) {
        case LOAN_TYPE_HOT:
            return @"热门贷款";
        case LOAN_TYPE_RECOMMEND:
            return @"编辑推荐";
        case LOAN_TYPE_NEW:
            return @"新品专区";
        case LOAN_TYPE_FAST:
            return @"极速赚钱";
        case LOAN_TYPE_PASS:
            return @"高通过率";
        default:
            break;
    }
    return nil;
}

+(NSString *)getVersionDescription{
    NSString* mode = @"";
//    if (isUserProxyMode) {
//        mode = ConcatStrings(@"(监控模式",(hasPermission ? @"可上报" : @""),@")");
//    }
    NSString* baseName;
    if (DEBUG_MODE) {
        baseName = ConcatStrings(@"debug v",[LocalBundleManager getAppVersion],@"(",@([LocalBundleManager getAppCode]),@")",mode);
    }else{
        baseName = ConcatStrings(@"v",[LocalBundleManager getAppVersion],@"(",@([LocalBundleManager getAppCode]),@")",mode);
    }
//    switch ([NetConfig getCurrentNetMode]) {
//        case NetModeTypePersonYan:return ConcatStrings(@"Ywj ",baseName);
//        case NetModeTypePersonZhou:return ConcatStrings(@"Zq ",baseName);
//        case NetModeTypePersonLiu:return ConcatStrings(@"Lz ",baseName);
//        case NetModeTypePersonWang:return ConcatStrings(@"Wsj ",baseName);
//        case NetModeTypePersonZhu:return ConcatStrings(@"Zjd ",baseName);
//        case NetModeTypePersonZheng:return ConcatStrings(@"Zxx ",baseName);
//        case NetModeTypePersonGao:return ConcatStrings(@"Gy ",baseName);
//        case NetModeTypePersonGuo:return ConcatStrings(@"Glq ",baseName);
//        case NetModeTypeDemo:return ConcatStrings(@"Demo ",baseName);
//        case NetModeTypeTest:return ConcatStrings(@"Test ",baseName);
//        case NetModeTypeUat:return ConcatStrings(@"Uat ",baseName);
//        case NetModeTypeRelease:return baseName;
//        case NetModeTypeReleaseT9:return ConcatStrings(@"T9 ",baseName);;
//    }
    return baseName;
}

@end
