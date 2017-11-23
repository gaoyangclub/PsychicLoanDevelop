//
//  CustomerServiceCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "CustomerServiceCell.h"

@interface CustomerServiceCell()

@property(nonatomic,retain) ASTextNode* publicLabel;//公众号
@property(nonatomic,retain) ASTextNode* wechatLabel;//微信号

@end

@implementation CustomerServiceCell

-(ASTextNode *)publicLabel{
    if (!_publicLabel) {
        _publicLabel = [[ASTextNode alloc]init];
        _publicLabel.layerBacked = YES;
        _publicLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:@"客服公众号:"];
        _publicLabel.size = [_publicLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_publicLabel.layer];
    }
    return _publicLabel;
}

-(ASTextNode *)wechatLabel{
    if (!_wechatLabel) {
        _wechatLabel = [[ASTextNode alloc]init];
        _wechatLabel.layerBacked = YES;
        _wechatLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:@"客服微信号:"];
        _wechatLabel.size = [_wechatLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_wechatLabel.layer];
    }
    return _wechatLabel;
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat const leftMargin = rpx(20);
    CGFloat const nodeGap = rpx(5);
    
    CGFloat const baseY = (self.height - self.publicLabel.height - self.wechatLabel.height - nodeGap) / 2.;
    
    self.publicLabel.x = self.wechatLabel.x = leftMargin;
    self.publicLabel.y = baseY;
    self.wechatLabel.y = self.publicLabel.maxY + nodeGap;
}

-(BOOL)showSelectionStyle{
    return NO;
}

@end
