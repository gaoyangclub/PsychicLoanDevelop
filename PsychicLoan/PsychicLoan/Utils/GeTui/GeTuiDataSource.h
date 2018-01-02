//
//  GeTuiDataSource.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//#import <UserNotifications/UserNotifications.h>
#endif

@interface GeTuiDataSource : NSObject

//-(void)start;//注:放弃在DataSource中初始化 收不到GeTuiSdkDidReceivePayloadData代理方法的反馈信息

+(void)addLocalNotification:(NSString*)msg;

@end
