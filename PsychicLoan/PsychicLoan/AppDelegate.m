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
//#import <GTSDK/GeTuiSdk.h>
//#import "GeTuiDataSource.h"
#import "PushModel.h"

@interface AppDelegate()//<GeTuiSdkDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NetRequestClass initNetWorkStatus];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
//    GeTuiDataSource* geTuiDataSource = [[GeTuiDataSource alloc]init];
//    [geTuiDataSource start];
    
    //    [GeTuiSdk clientId];
    // 注册 APNs
    [self registerRemoteNotification];
//    [self startGeTuiSdk];
    
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

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        ////        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        ////        center.delegate = self;
        ////        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
        ////            if (!error) {
        ////                NSLog(@"request authorization succeeded!");
        ////            }
        ////        }];
        ////
        ////        [[UIApplication sharedApplication] registerForRemoteNotifications];
        //#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        //#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

//-(void)startGeTuiSdk{
//    [GeTuiSdk startSdkWithAppId:GETUI_APPID appKey:GETUI_APPKEY appSecret:GETUI_APPSECRET delegate:self];//开启推送
////    [GeTuiSdk runBackgroundEnable:YES];
//    
//    NSString* clientId = [GeTuiSdk clientId];
//    if(clientId){//sdk早就注册了
////        [self registerGeTuiAppClient:clientId];
//    }
//}

#pragma GeTuiSdkDelegate
/** SDK启动成功返回cid */
//-(void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
//    //    //个推SDK已注册，返回clientId
//    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
////    [self registerGeTuiAppClient:clientId];
//}
//
//#pragma GeTuiSdkDelegate
//-(void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId{
//    if (payloadData) {
//        NSString *payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
//                                                        length:payloadData.length
//                                                      encoding:NSUTF8StringEncoding];
//        NSLog(@"Payload Msg:%@", payloadMsg);
//        PushModel* pushMsg = [PushModel yy_modelWithJSON:payloadData];
//        if(pushMsg){
//            [GeTuiDataSource addLocalNotification:pushMsg.pushmessage];
//            if (pushMsg.type == 1) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_SHOW_HOME_POP object:pushMsg];
//            }
//        }else{
//            [GeTuiDataSource addLocalNotification:payloadMsg];
//        }
//    }
//    // 汇报个推自定义事件
//    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
//}
//
////为了免除开发者维护DeviceToken的麻烦，个推SDK可以帮开发者管理好这些繁琐的事务。应用开发者只需调用个推SDK的接口汇报最新的DeviceToken，即可通过个推平台推送 APNs 消息。示例代码如下：
///** 远程通知注册成功委托 */
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
//    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
//    
//    // 向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
//}
//
////在iOS 10 以前，为处理 APNs 通知点击事件，统计有效用户点击数，需在AppDelegate.m里的didReceiveRemoteNotification回调方法中调用个推SDK统计接口：
///** APP已经接收到“远程”通知(推送) - 透传推送消息  */
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
//    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
//    
//    // 将收到的APNs信息传给个推统计
//    [GeTuiSdk handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

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
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_APP_BECOME_ACTIVE object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
