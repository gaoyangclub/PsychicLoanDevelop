//
//  AppDelegate.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppViewManager.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"

#import "UMMobClick/MobClick.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import "GeTuiSdk.h"
#import "GeTuiDataSource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NetRequestClass initNetWorkStatus];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
//    [self startGeTuiSdk];
    GeTuiDataSource* geTuiDataSource = [[GeTuiDataSource alloc]init];
    [geTuiDataSource start];
    
    //    [GeTuiSdk clientId];
    // 注册 APNs
//    [self registerRemoteNotification];
    
    [AppViewManager setRootTabBarController:[AppViewManager createTabBarController]];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [AppViewManager getRootTabBarController];//可替换
    
    UMConfigInstance.appKey = UM_APPID;
//    //    UMConfigInstance.ChannelId = @"App Store";
    //    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    YWFeedbackKit* feedBackKit = [[YWFeedbackKit alloc]initWithAppKey:FEEDBACK_APPKEY appSecret:FEEDBACK_APPSECRET];
    feedBackKit.extInfo = @{};//扩展数据
    [AppViewManager setYWFeedbackKit:feedBackKit];
    
    [AppViewManager showSplashView];
    
    return YES;
}

//为了免除开发者维护DeviceToken的麻烦，个推SDK可以帮开发者管理好这些繁琐的事务。应用开发者只需调用个推SDK的接口汇报最新的DeviceToken，即可通过个推平台推送 APNs 消息。示例代码如下：
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

//在iOS 10 以前，为处理 APNs 通知点击事件，统计有效用户点击数，需在AppDelegate.m里的didReceiveRemoteNotification回调方法中调用个推SDK统计接口：
/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
