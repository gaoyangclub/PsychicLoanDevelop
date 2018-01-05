//
//  DiyRotateRefreshHeader.m
//  MJRefreshTest
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DiyRotateRefreshHeader.h"

@interface DiyRotateRefreshHeader()

@property(nonatomic,retain)UILabel* rotateView;

@end

@implementation DiyRotateRefreshHeader

-(UILabel *)rotateView{
    if (!_rotateView) {
        _rotateView = [[UILabel alloc]init];
        UIFont *iconfont = [UIFont fontWithName:ICON_FONT_NAME size: rpx(30)];
        _rotateView.font = iconfont;
        _rotateView.text = ICON_LOADING;
        _rotateView.textColor = COLOR_PRIMARY;
        [_rotateView sizeToFit];
        [self addSubview:_rotateView];
    }
    return _rotateView;
}

-(void)placeSubviews{
    [super placeSubviews];
    
//    CGFloat radius = 30;
//    self.cuteView.frame = CGRectMake(CGRectGetWidth(self.bounds) / 2 - radius / 2, CGRectGetHeight(self.bounds) / 2 - radius / 2, radius, radius);
    
//    self.automaticallyChangeAlpha = NO;
    
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 圈圈
    self.rotateView.center = arrowCenter;
}


-(void)setState:(MJRefreshState)state{
    
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.6;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        rotationAnimation.fillMode = kCAFillModeForwards;
//        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.rotateView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
    }if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            
            [self.rotateView.layer removeAllAnimations];
//            CATransform3D transform = (CGAffineTransform)self.rotateView.layer.transform;
//            transform.rotation
//            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//            rotationAnimation.duration = 0.4;
//            rotationAnimation.fillMode = kCAFillModeForwards;
//            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//            [self.rotateView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        }
    }
}


//-(void)setPullingPercent:(CGFloat)pullingPercent{
//    [super setPullingPercent:pullingPercent];
//////    if (pullingPercent == 0) {
//////        self.cuteView.alpha = 1;
//////    }
////    self.rotateView.transform = CGAffineTransformMakeRotation(pullingPercent * 360 *M_PI / 180.0);
////    
////    NSLog(@"pullingPercent:%f",pullingPercent);
//}

//-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
////    self.scrollView.contentOffset.y + CGRectGetHeight(self.bounds));
//    
//    self.rotateView.transform = CGAffineTransformMakeRotation(self.scrollView.contentOffset.y * 36 *M_PI / 180.0);
//    
//    [super scrollViewContentOffsetDidChange:change];
//}


@end
