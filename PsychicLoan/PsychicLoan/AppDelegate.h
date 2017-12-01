//
//  AppDelegate.h
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong) UIWindow *window;

@property(nonatomic,retain) GYTabBarController* rootTabBarController;

-(void)popLoginViewController;//全局弹出登录界面

+(UINavigationController *)getCurrentNavigationController;

@end

