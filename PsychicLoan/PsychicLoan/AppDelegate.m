//
//  AppDelegate.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GYTabBarController.h"
#import "IQKeyboardManager.h"

#import "UMMobClick/MobClick.h"
#import "DIYTabBarItem.h"
#import "HomeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//获取当前屏幕显示的viewcontroller
+ (UINavigationController *)getCurrentNavigationController{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UINavigationController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UINavigationController *currentNaviVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        currentNaviVC = [rootVC presentedViewController].navigationController;
    } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentNaviVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        if ([rootVC isMemberOfClass:[JKRootNavigationController class]]) {
            currentNaviVC = [(UINavigationController *)rootVC visibleViewController].childViewControllers.firstObject;
        }else{
            currentNaviVC = (UINavigationController *)rootVC;
        }
    } else {
        // 根视图为非导航类
        currentNaviVC = rootVC.navigationController;
    }
    return currentNaviVC;
}

-(JKRootNavigationController*)createNavigationController:(UIViewController*)viewController{
    JKRootNavigationController* navigationController = [[JKRootNavigationController alloc]initWithRootViewController:viewController];
    navigationController.automaticallyAdjustsScrollViewInsets = navigationController.navigationBar.translucent = NO;
    /// 全局效果
    //    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    /// 只会设置当前控制器的navigationBar的颜色
    //    [navigationController.navigationBar jk_setNavigationBarBackgroundColor:[UIColor orangeColor]];
    ///  会设置所有子控制器的全屏手势使能状态，全局效果
    navigationController.jk_fullScreenPopGestrueEnabled = YES;
    return navigationController;
}

-(GYTabBarController*)createNormalTabBar{
    UINavigationController* itemCtrl1 = [self createNavigationController:[[HomeViewController alloc] init]];
    UINavigationController* itemCtrl2 = [self createNavigationController:[[ViewController alloc] init]];
    itemCtrl2.title = @"测试标题2";
    
//    UINavigationController* itemCtrl3 = [self createNavigationController:[[SortViewController alloc] init]];
//    itemCtrl3.title = @"测试标题3";
    
    UINavigationController* itemCtrl4 = [self createNavigationController:[[ViewController alloc] init]];
    itemCtrl4.title = @"测试标题4";
    
    GYTabBarController* tabBarCtl = [[GYTabBarController alloc] init];
    tabBarCtl.itemClass = [DIYTabBarItem class];
    tabBarCtl.dataArray = @[[TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_HOME image:@"\U00003605"] controller:itemCtrl1],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_LOAN image:@"\U0000346c"] controller:itemCtrl2],
//                            [TabData initWithParams:[DIYBarData initWithParams:@"付款" image:@"\U0000346e"] controller:itemCtrl3],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_USER image:@"\U000035ec"] controller:itemCtrl4],
                            ];
//    [tabBarCtl setItemBadge:20 atIndex:0];
//    [tabBarCtl setItemBadge:5 atIndex:1];
    //    [tabBarCtl setItemBadge:80 atIndex:2];
//    [tabBarCtl setItemBadge:100 atIndex:3];
    return tabBarCtl;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NetRequestClass initNetWorkStatus];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    //    [self startGeTuiSdk];
    
    //    [GeTuiSdk clientId];
    // 注册 APNs
    [self registerRemoteNotification];
    
    self.rootTabBarController = [self createNormalTabBar];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.rootTabBarController;//可替换
    
//    UMConfigInstance.appKey = UM_APPID;
//    //    UMConfigInstance.ChannelId = @"App Store";
//    //    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
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
