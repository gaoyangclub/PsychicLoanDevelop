//
//  AppViewManager.h
//  PsychicLoan
//
//  Created by admin on 2017/12/4.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYTabBarController.h"
#import "LoanModel.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>

@interface AppViewManager : NSObject

//+(void)setRootWindow:(UIWindow *)value;
//+(UIWindow *)getRootWindow;

+(void)setYWFeedbackKit:(YWFeedbackKit*)value;

+(void)openFeedbackViewController:(UINavigationController*)navigationController;

+(void)setRootTabBarController:(GYTabBarController*)value;
+(GYTabBarController*)getRootTabBarController;

+(void)popLoginViewController;//全局弹出登录界面

+(void)popLoginNextWebController:(LoanModel*)loanModel navigationController:(UINavigationController*)navigationController;

+(UINavigationController *)getCurrentNavigationController;

+(GYTabBarController*)createTabBarController;

@end
