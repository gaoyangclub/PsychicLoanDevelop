//
//  HudManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HudManager.h"

//static HudManager* instance;

@implementation HudManager

//+(instancetype)sharedInstance {
//    @synchronized (self)    {
//        if (instance == nil)
//        {
//            instance = [[self alloc] init];
//        }
//    }
//    return instance;
//}

+(void)showToast:(NSString *)value{
    [HudManager showToast:value delay:2];
}

+(void)showToast:(NSString *)value delay:(CGFloat)delay{
    UIView *window = [HudManager getParentView];
    // 添加到窗口
    MBProgressHUD* hud = [[MBProgressHUD alloc]initWithView:window];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.userInteractionEnabled = NO;
    //        hud.backgroundColor = [UIColor blackColor];
    [window addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = value;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
}

+(UIView*)getParentView{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
            break;
        }
    }
    return [[UIApplication sharedApplication].windows lastObject];
}

@end
