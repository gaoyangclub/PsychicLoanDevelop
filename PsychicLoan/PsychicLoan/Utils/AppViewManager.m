//
//  AppViewManager.m
//  PsychicLoan
//
//  Created by admin on 2017/12/4.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "AppViewManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DIYTabBarItem.h"
#import "UserHomeController.h"
#import "LoanMarketViewController.h"
#import "HomeViewController.h"
#import "UserDefaultsUtils.h"
#import "WebViewController.h"

#import <YWFeedbackFMWK/YWFeedbackViewController.h>

//@property(nonatomic,strong) UIWindow *window;
//@property(nonatomic,strong) GYTabBarController* rootTabBarController;

//static UIWindow *rootWindow;
static GYTabBarController* rootTabBarController;
static YWFeedbackKit* feedBackKit;

@implementation AppViewManager

//+(void)setRootWindow:(UIWindow *)value{
//    rootWindow = value;
//}
//
//+(UIWindow *)getRootWindow{
//    return rootWindow;
//}

+(void)setYWFeedbackKit:(YWFeedbackKit*)value{
    feedBackKit = value;
}

+(void)openFeedbackViewController:(UINavigationController *)navigationController{
    
    [feedBackKit makeFeedbackViewControllerWithCompletionBlock:^(BCFeedbackViewController *viewController, NSError *error) {
//        [navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//        viewController.hidesBottomBarWhenPushed = YES;
        [navigationController pushViewController:viewController animated:YES];//点开反馈界面
        viewController.navigationItem.leftBarButtonItem = nil;
//        viewController.edgesForExtendedLayout = UIRectEdgeNone;
//        viewController.automaticallyAdjustsScrollViewInsets = NO;
        //[rootTabBarController presentViewController:viewController animated:YES completion:nil];
        [viewController setCloseBlock:^(UIViewController *aParentController){
            // 进行 dismiss 或者 pop，以及一些相关设置
//            [aParentController dismissViewControllerAnimated:YES completion:nil];
            [navigationController popViewControllerAnimated:YES];//返回上级页面
        }];
    }];
}

+(void)setRootTabBarController:(GYTabBarController*)value{
    rootTabBarController = value;
}

+(GYTabBarController*)getRootTabBarController{
    return rootTabBarController;
}

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

+ (void)popLoginNextWebController:(LoanModel *)loanModel navigationController:(UINavigationController*)navigationController{
    if (![UserDefaultsUtils getObject:PHONE_KEY]) {//重新登录
        [AppViewManager popLoginViewController];
        __block RACDisposable* notifationHandler = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:EVENT_LOGIN_COMPLETE object:nil] subscribeNext:^(id x) {
            [AppViewManager gotoWebViewController:loanModel navigationController:navigationController animated:NO];
            [notifationHandler dispose];
        }];
    }else{
        [AppViewManager gotoWebViewController:loanModel navigationController:navigationController animated:YES];
    }
}

+ (void)gotoWebViewController:(LoanModel *)loanModel navigationController:(UINavigationController*)navigationController animated:(BOOL)animated{
    WebViewController* viewController = [[WebViewController alloc]init];
    viewController.loanId = loanModel.loanid;
    viewController.navigationTitle = loanModel.loanname;
    //    viewController.hidesBottomBarWhenPushed = YES;
    viewController.linkUrl = loanModel.loanurl;
    [navigationController pushViewController:viewController animated:animated];
}

+ (void)popLoginViewController{
    LoginViewController* loginViewController = [[LoginViewController alloc]init];
    JKRootNavigationController* navigationController = [[JKRootNavigationController alloc]initWithRootViewController:loginViewController];
    navigationController.automaticallyAdjustsScrollViewInsets = navigationController.navigationBar.translucent = NO;
    [rootTabBarController presentViewController:navigationController animated:YES completion:nil];
}

+ (JKRootNavigationController*)createNavigationController:(UIViewController*)viewController{
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

+ (GYTabBarController*)createTabBarController{
    UINavigationController* itemCtrl1 = [self createNavigationController:[[HomeViewController alloc] init]];
    UINavigationController* itemCtrl2 = [self createNavigationController:[[LoanMarketViewController alloc] init]];
    itemCtrl2.title = @"测试标题2";
    
    //    UINavigationController* itemCtrl3 = [self createNavigationController:[[SortViewController alloc] init]];
    //    itemCtrl3.title = @"测试标题3";
    
    UINavigationController* itemCtrl4 = [self createNavigationController:[[UserHomeController alloc] init]];
    itemCtrl4.title = @"测试标题4";
    
    GYTabBarController* tabBarCtl = [[GYTabBarController alloc] init];
    tabBarCtl.itemClass = [DIYTabBarItem class];
    tabBarCtl.dataArray = @[[TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_HOME image:ICON_SHOU_YE selectedImage:ICON_SHOU_YE_SELECTED] controller:itemCtrl1],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_LOAN image:ICON_DAI_KUAN selectedImage:ICON_DAI_KUAN_SELECTED] controller:itemCtrl2],
                            //                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_LOAN image:ICON_XIAO_XI selectedImage:ICON_XIAO_XI_SELECTED] controller:itemCtrl3],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_USER image:ICON_WO_DE selectedImage:ICON_WO_DE_SELECTED] controller:itemCtrl4],
                            ];
    //    [tabBarCtl setItemBadge:20 atIndex:0];
    //    [tabBarCtl setItemBadge:5 atIndex:1];
    //    [tabBarCtl setItemBadge:80 atIndex:2];
    //    [tabBarCtl setItemBadge:100 atIndex:3];
    return tabBarCtl;
}

@end
