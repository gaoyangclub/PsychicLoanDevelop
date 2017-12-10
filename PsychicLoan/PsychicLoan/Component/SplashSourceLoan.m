//
//  SplashSourceLoan.m
//  PsychicLoan
//
//  Created by 高扬 on 17/12/9.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "SplashSourceLoan.h"

@interface SplashSourceLoan (){
    BOOL isAnimation;//
}

@property(nonatomic,retain) UIImageView* backImg;

@end

@implementation SplashSourceLoan

-(UIImageView *)backImg{
    if (!_backImg) {
        UIImage* image = [UIImage imageNamed:@"splashBackground.jpg"];
        _backImg = [[UIImageView alloc]initWithImage:image];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_backImg];
    }
    return _backImg;
}

-(void)display{
    self.backImg.frame = self.bounds;
}

@end
