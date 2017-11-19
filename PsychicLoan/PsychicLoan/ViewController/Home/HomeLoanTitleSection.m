//
//  HomeLoanTitleSection.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeLoanTitleSection.h"

@interface HomeLoanTitleSection()

@property(nonatomic,retain) ASTextNode* titleNode;

@end

@implementation HomeLoanTitleSection

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = COLOR_BACKGROUND;
    
    NSString* title = [Config getLoanTypeNameByCode:self.data];
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_PRIMARY content:title];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleNode.centerY = self.height / 2.;
    self.titleNode.x = rpx(10);
}

@end
