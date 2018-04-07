//
//  UIViewController+HidesBottomBar.m
//  PsychicLoan
//
//  Created by 高扬 on 17/12/10.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "UIViewController+HidesBottomBar.h"

@implementation UIViewController (HidesBottomBar)

+(void)load{
    [self swizzleMethod:@selector(viewDidLoad) withMethod:@selector(gy_viewDidLoad)];
}

-(void)gy_viewDidLoad{
//    if (self.hidesBottomBarWhenPushed) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    [self gy_viewDidLoad];
}

@end
