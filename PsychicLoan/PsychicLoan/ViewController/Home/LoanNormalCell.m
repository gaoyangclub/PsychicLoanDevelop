//
//  LoanNormalCell.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanNormalCell.h"
#import "FlatButton.h"
#import "LoanModel.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "WebViewController.h"

@interface LoanNormalCell()

@property(nonatomic,retain) UIImageView* iconView;
@property(nonatomic,retain) ASDisplayNode* backNode;
@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) ASTextNode* amountNode;
@property(nonatomic,retain) ASTextNode* describeNode;
@property(nonatomic,retain) FlatButton* linkButton;//跳转链接

@end

@implementation LoanNormalCell

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
//        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

-(ASDisplayNode *)backNode{
    if (!_backNode) {
        _backNode = [[ASDisplayNode alloc]init];
        _backNode.backgroundColor = [UIColor whiteColor];
        _backNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)amountNode{
    if (!_amountNode) {
        _amountNode = [[ASTextNode alloc]init];
        _amountNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_amountNode.layer];
    }
    return _amountNode;
}

-(ASTextNode *)describeNode{
    if (!_describeNode) {
        _describeNode = [[ASTextNode alloc]init];
        _describeNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_describeNode.layer];
    }
    return _describeNode;
}

-(FlatButton *)linkButton{
    if (!_linkButton) {
        _linkButton = [[FlatButton alloc]init];
        _linkButton.strokeColor = COLOR_LINE;
        _linkButton.strokeWidth = LINE_WIDTH;
        _linkButton.cornerRadius = rpx(5);
        _linkButton.fillColor = [UIColor whiteColor];
        _linkButton.titleColor = COLOR_TEXT_PRIMARY;
        _linkButton.title = @"借钱";
        _linkButton.titleSize = SIZE_TEXT_PRIMARY;
        _linkButton.size = CGSizeMake(rpx(60), rpx(26));
        [self.contentView addSubview:_linkButton];
        [_linkButton addTarget:self action:@selector(clickLinkButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkButton;
}

-(void)clickLinkButton:(UIView*)sender{
    WebViewController* viewController = [[WebViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.linkUrl = ((LoanModel*)self.data).loanurl;
    [[AppDelegate getCurrentNavigationController]pushViewController:viewController animated:YES];
}

-(void)showSubviews{
    
    LoanModel* loanModel = self.data;
    
    CGFloat const leftMargin = rpx(10);
    
    self.backNode.frame = CGRectMake(leftMargin, 0, self.contentView.width - leftMargin * 2, self.contentView.height);
    
    CGFloat const iconWidth = self.contentView.height - leftMargin * 2;
    self.iconView.size = CGSizeMake(iconWidth, iconWidth);
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = leftMargin * 2;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:loanModel.loanlogo]];
    
    CGFloat const textGap = rpx(3);
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:loanModel.loanname isBold:YES];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.amountNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:[NSString stringWithFormat:@"%ld",loanModel.maxamount]];
    self.amountNode.size = [self.amountNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.describeNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_THIRD size:SIZE_TEXT_SECONDARY content:loanModel.loandes];
    self.describeNode.size = [self.describeNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleNode.x = self.amountNode.x = self.describeNode.x = self.iconView.maxX + leftMargin;
    
    CGFloat const baseY = (self.height - self.titleNode.height - self.amountNode.height - self.describeNode.height - textGap * 2) / 2.;
    self.titleNode.y = baseY;
    self.amountNode.y = self.titleNode.maxY + textGap;
    self.describeNode.y = self.amountNode.maxY + textGap;
    
    self.linkButton.centerY = self.contentView.height / 2.;
    self.linkButton.maxX = self.contentView.width - leftMargin * 2;
    
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
