//
//  GeTuiDataSource.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "GeTuiDataSource.h"
#import "PushModel.h"

/// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId           @"eQm4quft4tAjkfW3YKUXO7"
#define kGtAppKey          @"GpwBMeI9ZJ8aEc6I5qEVG1"
#define kGtAppSecret       @"0va0OYjTBY6aEPMf3JpHZ8"


@interface GeTuiDataSource()<GeTuiSdkDelegate>//UNUserNotificationCenterDelegate

@end

@implementation GeTuiDataSource

-(void)start{
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    [GeTuiSdk runBackgroundEnable:YES];
    // 注册 APNs
    [self registerRemoteNotification];
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

#pragma GeTuiSdkDelegate  SDK启动成功返回cid
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

#pragma GeTuiSdkDelegate  SDK收到透传消息回调
-(void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId{
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
        
        PushModel* pushMsg = [PushModel yy_modelWithJSON:payloadData];
        [GeTuiDataSource addLocalNotification:pushMsg.pushmessage];
        if (pushMsg.type == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_SHOW_HOME_POP object:pushMsg];
        }
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    // 汇报个推自定义事件
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
}

#pragma mark 添加本地通知
+(void)addLocalNotification:(NSString*)msg{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = msg;
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1]; // 3秒钟后
    
    //--------------------可选属性------------------------------
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2) {
    //        localNotification.alertTitle = @"推送通知提示标题：alertTitle"; // iOS8.2
    //    }
    
    // 锁屏时在推送消息的最下方显示设置的提示字符串
    localNotification.alertAction = @"查看";//滑动来+查看
    
    // 当点击推送通知消息时，首先显示启动图片，然后再打开App, 默认是直接打开App的
//    localNotification.alertLaunchImage = @"splashLogo.png";
    
    // 默认是没有任何声音的 UILocalNotificationDefaultSoundName：声音类似于震动的声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    // 传递参数
    //    localNotification.userInfo = @{@"type": @"1"};
    
    //重复间隔：类似于定时器，每隔一段时间就发送通知
    //  localNotification.repeatInterval = kCFCalendarUnitSecond;
    
    //    localNotification.category = @"choose"; // 附加操作
    
    // 定时发送
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
