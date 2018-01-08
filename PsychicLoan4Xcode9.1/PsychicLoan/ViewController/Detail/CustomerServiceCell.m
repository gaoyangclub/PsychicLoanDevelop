//
//  CustomerServiceCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "CustomerServiceCell.h"
#import "FlatButton.h"
#import "OpenUrlUtils.h"
#import "AppViewManager.h"
#import "MobClickEventManager.h"

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
        _publicLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"客服公众号"];
        [_publicLabel sizeToFit];
        [self.contentView.layer addSublayer:_publicLabel.layer];
    }
    return _publicLabel;
}

-(ASTextNode *)wechatLabel{
    if (!_wechatLabel) {
        _wechatLabel = [[ASTextNode alloc]init];
        _wechatLabel.layerBacked = YES;
        _wechatLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"客服微信号"];
        [_wechatLabel sizeToFit];
        [self.contentView.layer addSublayer:_wechatLabel.layer];
    }
    return _wechatLabel;
}

-(ASTextNode *)publicNode{
    if (!_publicNode) {
        _publicNode = [[ASTextNode alloc]init];
        _publicNode.layerBacked = YES;
        _publicNode.attributedText = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:CUSTOMER_SERVICE_PUBLIC_TEXT];
        [_publicNode sizeToFit];
        [self.contentView.layer addSublayer:_publicNode.layer];
    }
    return _publicNode;
}

-(ASTextNode *)wechatNode{
    if (!_wechatNode) {
        _wechatNode = [[ASTextNode alloc]init];
        _wechatNode.layerBacked = YES;
        _wechatNode.attributedText = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:CUSTOMER_SERVICE_WECHAT_TEXT];
        [_wechatNode sizeToFit];
        [self.contentView.layer addSublayer:_wechatNode.layer];
    }
    return _wechatNode;
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
        _publicCopyButton.size = CGSizeMake(rpx(56), rpx(25));
        _publicCopyButton.fillColor = COLOR_PRIMARY;
        [self.contentView addSubview:_publicCopyButton];
        
        [_publicCopyButton addTarget:self action:@selector(clickCopyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publicCopyButton;
}

-(FlatButton *)wechatCopyButton{
    if (!_wechatCopyButton) {
        _wechatCopyButton = [[FlatButton alloc]init];
        _wechatCopyButton.icon = ICON_FU_ZHI;
        _wechatCopyButton.iconSize = rpx(16);
        _wechatCopyButton.iconColor = _publicCopyButton.titleColor = [UIColor whiteColor];
        _wechatCopyButton.iconGap = rpx(3);
        _wechatCopyButton.title = @"复制";
        _wechatCopyButton.titleSize = SIZE_TEXT_SECONDARY;
        _wechatCopyButton.size = CGSizeMake(rpx(56), rpx(25));
        _wechatCopyButton.fillColor = COLOR_PRIMARY;
        [self.contentView addSubview:_wechatCopyButton];
        
        [_wechatCopyButton addTarget:self action:@selector(clickCopyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatCopyButton;
}

-(void)clickCopyButton:(UIView*)sender{
    if (sender == self.publicCopyButton) {
        [self showCopyAlert:CUSTOMER_SERVICE_PUBLIC_TEXT alertMessage:@"已复制微信公众号，去微信搜索加关注更多贷款新口子每天更新！"];
    }else{
        [self showCopyAlert:CUSTOMER_SERVICE_WECHAT_TEXT alertMessage:@"已复制客服微信号，去微信添加客服好友！"];
    }
    if (self.data && [MOBCLICK_EVENT_DETAIL_CUSTOMER isEqual:self.data]) {
        [MobClickEventManager detailCustomerClick];
    }else if(self.data && [MOBCLICK_EVENT_USER_CUSTOMER isEqual:self.data]){
        [MobClickEventManager userCustomerClick];
    }
}

-(void)showCopyAlert:(NSString*)copyString alertMessage:(NSString*)alertMessage{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = copyString;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"去微信" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [OpenUrlUtils openUrlByString:@"weixin://"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
    [[AppViewManager getRootTabBarController] presentViewController:alertController animated:YES completion:nil];
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat const leftMargin = rpx(20);
    CGFloat const nodeGap = rpx(20);
    
    CGFloat const baseY = (self.height - self.publicLabel.height - self.wechatLabel.height - nodeGap) / 2.;
    
    self.publicLabel.x = self.wechatLabel.x = leftMargin;
    self.publicLabel.y = baseY;
    self.wechatLabel.y = self.publicLabel.maxY + nodeGap;
    
    self.publicNode.x = self.publicLabel.maxX + leftMargin;
    self.publicCopyButton.x = self.publicNode.maxX + leftMargin;
    self.publicNode.centerY = self.publicCopyButton.centerY = self.publicLabel.centerY;
    
    self.wechatNode.x = self.wechatLabel.maxX + leftMargin;
    self.wechatCopyButton.x = self.wechatNode.maxX + leftMargin;
    self.wechatNode.centerY = self.wechatCopyButton.centerY = self.wechatLabel.centerY;
}

-(BOOL)showSelectionStyle{
    return NO;
}

@end
