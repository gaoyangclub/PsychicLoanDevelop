//
//  DetailLogoCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailLogoCell.h"
#import "LoanDetailModel.h"
#import "UIImageView+WebCache.h"

@interface DetailLogoCell()

@property(nonatomic,retain) UIImageView* iconView;
//@property(nonatomic,retain) ASDisplayNode* backNode;
@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) ASTextNode* amountNode;
@property(nonatomic,retain) ASTextNode* describeNode;
//@property(nonatomic,retain) FlatButton* linkButton;//跳转链接

@end

@implementation DetailLogoCell

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        //        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

//-(ASDisplayNode *)backNode{
//    if (!_backNode) {
//        _backNode = [[ASDisplayNode alloc]init];
//        _backNode.backgroundColor = [UIColor whiteColor];
//        _backNode.layerBacked = YES;
//        [self.contentView.layer addSublayer:_backNode.layer];
//    }
//    return _backNode;
//}

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

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    LoanDetailModel* loanModel = self.data;
    
    CGFloat const leftMargin = rpx(20);
//    self.backNode.frame = CGRectMake(leftMargin, 0, self.contentView.width - leftMargin * 2, self.contentView.height);
    
    CGFloat const iconWidth = self.contentView.height - leftMargin;
    self.iconView.size = CGSizeMake(iconWidth, iconWidth);
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = leftMargin;
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
    
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
