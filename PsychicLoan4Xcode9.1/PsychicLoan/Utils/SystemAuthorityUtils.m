//
//  SystemAuthorityUtils.m
//  PsychicLoan
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "SystemAuthorityUtils.h"

@implementation SystemAuthorityUtils

+(void)checkNetWorkReachability:(void (^)())nextHandler{
    if (![NetRequestClass netWorkReachability]) {//网络异常
        UIAlertView *alert;
        NSString* alertTitle;
        NSString* alertMessage;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
            alertTitle = [NSString stringWithFormat:@"[使用无线局域网与蜂窝移动的应用]来允许%@使用网络",[LocalBundleManager getAppName]];
            alertMessage = [NSString stringWithFormat:@"请在系统设置中开启网络权限\n(设置>蜂窝移动网络>使用无线局域网与蜂窝移动的应用>%@>开启)",[LocalBundleManager getAppName]];
        }else{
            alertTitle = [NSString stringWithFormat:@"打开wifi来允许%@使用网络",[LocalBundleManager getAppName]];
            alertMessage = @"请在系统设置中开启网络权限\n(设置>无线局域网>开启)";
        }
        alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"取消", nil];
//        alert.tag = 404;
        [alert show];
        
        [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                NSURL *url;
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                    url = [NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];//跳转蜂窝移动设置页面
                }else{
                    url = [NSURL URLWithString:@"prefs:root=WIFI"];//跳转wifi
                }
                if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }];
        __block RACDisposable* notifationHandler = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:EVENT_APP_BECOME_ACTIVE object:nil] subscribeNext:^(id x) {
            [SystemAuthorityUtils checkNetWorkReachability:nextHandler];//继续检查
            [notifationHandler dispose];
        }];
    }else{
        if (nextHandler) {
            nextHandler();
        }
    }
}


//+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    //appVersion.downloadUrl
//    if(buttonIndex == 0){
//        if (alertView.tag == 404) {
//            NSURL *url;
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
//                url = [NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];//跳转蜂窝移动设置页面
//            }else{
//                url = [NSURL URLWithString:@"prefs:root=WIFI"];//跳转wifi
//            }
//            if( [[UIApplication sharedApplication] canOpenURL:url] ) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }
//    }
//}

@end
