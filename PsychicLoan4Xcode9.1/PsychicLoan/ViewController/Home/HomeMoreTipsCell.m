//
//  HomeMoreTipsCell.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeMoreTipsCell.h"
#import "FlatButton.h"
#import "AppDelegate.h"
#import "AppViewManager.h"

@interface HomeMoreTipsCell()

@property(nonatomic,retain) FlatButton* titleButton;
@property(nonatomic,retain) ASTextNode* tipsNode;

@end

@implementation HomeMoreTipsCell

-(FlatButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [[FlatButton alloc]init];
        _titleButton.title = HOME_MOER_BUTTON_NAME;
        _titleButton.titleColor = COLOR_PRIMARY;
        _titleButton.titleSize = SIZE_TEXT_SECONDARY;
        _titleButton.fillColor = [UIColor clearColor];
        _titleButton.icon = ICON_QIAN_JIN;
        _titleButton.iconSize = SIZE_TEXT_SECONDARY;
        _titleButton.iconColor = COLOR_PRIMARY;
        _titleButton.iconAlignment = IconAlignmentRight;
        _titleButton.iconGap = rpx(6);
        [self.contentView addSubview:_titleButton];
        [_titleButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

-(void)clickMoreButton:(UIView*)sender{
    [[AppViewManager getRootTabBarController] valueCommit:1];//选中理财超市
}

-(ASTextNode *)tipsNode{
    if (!_tipsNode) {
        _tipsNode = [[ASTextNode alloc]init];
        _tipsNode.layerBacked = YES;
        _tipsNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:HOME_MOER_TIPS];
        _tipsNode.size = [_tipsNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_tipsNode.layer];
    }
    return _tipsNode;
}

-(void)showSubviews{
    CGFloat const bottomMargin = rpx(10);
    
    self.titleButton.size = CGSizeMake(self.contentView.width, self.contentView.height - self.tipsNode.height - bottomMargin);
    self.titleButton.y = 0;
    
    self.tipsNode.centerX = self.titleButton.centerX = self.contentView.width / 2.;
    self.tipsNode.maxY = self.contentView.height - bottomMargin;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
