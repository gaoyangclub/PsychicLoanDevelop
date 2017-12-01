//
//  CustomerServiceCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "CustomerServiceCell.h"
#import "FlatButton.h"
#import "AppDelegate.h"
#import "OpenUrlUtils.h"

@interface CustomerServiceCell()

@property(nonatomic,retain) ASTextNode* publicLabel;//公众号
@property(nonatomic,retain) ASTextNode* wechatLabel;//微信号

@property(nonatomic,retain) ASTextNode* publicNode;//数据
@property(nonatomic,retain) ASTextNode* wechatNode;//数据

@property(nonatomic,retain) FlatButton* publicCopyButton;//复制公众号
@property(nonatomic,retain) FlatButton* wechatCopyButton;//复制微信号

@end

@implementation CustomerServiceCell

-(ASTextNode *)publicLabel{
    if (!_publicLabel) {
        _publicLabel = [[ASTextNode alloc]init];
        _publicLabel.layerBacked = YES;
        _publicLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"客服公众号:" isBold:YES];
        _publicLabel.size = [_publicLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_publicLabel.layer];
    }
    return _publicLabel;
}

-(ASTextNode *)wechatLabel{
    if (!_wechatLabel) {
        _wechatLabel = [[ASTextNode alloc]init];
        _wechatLabel.layerBacked = YES;
        _wechatLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"客服微信号:" isBold:YES];
        _wechatLabel.size = [_wechatLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_wechatLabel.layer];
    }
    return _wechatLabel;
}

-(ASTextNode *)publicNode{
    if (!_publicNode) {
        _publicNode = [[ASTextNode alloc]init];
        _publicNode.layerBacked = YES;
        _publicNode.attributedString = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:CUSTOMER_SERVICE_PUBLIC_TEXT];
        _publicNode.size = [_publicNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_publicNode.layer];
    }
    return _publicNode;
}

-(FlatButton *)publicCopyButton{
    if (!_publicCopyButton) {
        _publicCopyButton = [[FlatButton alloc]init];
        _publicCopyButton.icon = ICON_FU_ZHI;
        _publicCopyButton.iconSize = rpx(16);
        _publicCopyButton.iconColor = _publicCopyButton.titleColor = [UIColor whiteColor];
        _publicCopyButton.iconGap = rpx(3);
        _publicCopyButton.title = @"复制";
        _publicCopyButton.titleSize = SIZE_TEXT_SECONDARY;
        _publicCopyButton.size = CGSizeMake(rpx(56), rpx(22));
        _publicCopyButton.fillColor = COLOR_PRIMARY;
        [self.contentView addSubview:_publicCopyButton];
        
        [_publicCopyButton addTarget:self action:@selector(clickPublicButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publicCopyButton;
}

-(void)clickPublicButton{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = CUSTOMER_SERVICE_PUBLIC_TEXT;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已复制微信公众号，去微信搜索加关注更多贷款新口子每天更新！" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"去微信" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [OpenUrlUtils openUrlByString:@"weixin://"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabBarController presentViewController:alertController animated:YES completion:nil];
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat const leftMargin = rpx(20);
    CGFloat const nodeGap = rpx(5);
    
    CGFloat const baseY = (self.height - self.publicLabel.height - self.wechatLabel.height - nodeGap) / 2.;
    
    self.publicLabel.x = self.wechatLabel.x = leftMargin;
    self.publicLabel.y = baseY;
    self.wechatLabel.y = self.publicLabel.maxY + nodeGap;
    
    self.publicNode.x = self.publicLabel.maxX + leftMargin;
    self.publicCopyButton.x = self.publicNode.maxX + leftMargin;
    self.publicNode.centerY = self.publicCopyButton.centerY = self.publicLabel.centerY;
}

-(BOOL)showSelectionStyle{
    return NO;
}

@end
