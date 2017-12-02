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

@property(nonatomic,retain) ASTextNode* passRateLabel;//通过率
@property(nonatomic,retain) ASTextNode* passRateNode;

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

-(ASTextNode *)passRateLabel{
    if (!_passRateLabel) {
        _passRateLabel = [[ASTextNode alloc]init];
        _passRateLabel.layerBacked = YES;
        _passRateLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"通过率"];
        _passRateLabel.size = [_passRateLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_passRateLabel.layer];
    }
    return _passRateLabel;
}

-(ASTextNode *)passRateNode{
    if (!_passRateNode) {
        _passRateNode = [[ASTextNode alloc]init];
        _passRateNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_passRateNode.layer];
    }
    return _passRateNode;
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    LoanDetailModel* loanModel = self.data;
    
    CGFloat const leftMargin = rpx(20);
//    self.backNode.frame = CGRectMake(leftMargin, 0, self.contentView.width - leftMargin * 2, self.contentView.height);
    
    CGFloat const iconWidth = self.contentView.height - leftMargin * 2;
    self.iconView.size = CGSizeMake(iconWidth, iconWidth);
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = leftMargin;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:loanModel.loanlogo]];
    
    CGFloat const textGap = rpx(12);
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_LARGE content:loanModel.loanname];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.amountNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_PRIMARY content:
                                        ConcatStrings(@"放款时间:",@(loanModel.time),@"分钟")];
//                                        [NSString stringWithFormat:@"%ld",loanModel.maxamount]];
    self.amountNode.size = [self.amountNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.describeNode.attributedString = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:loanModel.loandes];
    self.describeNode.size = [self.describeNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleNode.x = self.amountNode.x = self.describeNode.x = self.iconView.maxX + leftMargin;
    
    CGFloat const baseY = (self.height - self.titleNode.height - self.amountNode.height - self.describeNode.height - textGap * 2) / 2.;
    self.titleNode.y = baseY;
    self.amountNode.y = self.titleNode.maxY + textGap;
    self.describeNode.y = self.amountNode.maxY + textGap;
    
    self.passRateNode.attributedString = [NSString simpleAttributedString:FlatRed size:rpx(24) content:ConcatStrings(loanModel.passrate,@"%")];
    self.passRateNode.size = [self.passRateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat const passY = (self.height - self.passRateLabel.height - self.passRateNode.height - textGap) / 2.;
    
    self.passRateLabel.x = self.passRateNode.x = self.contentView.width - rpx(83);
    self.passRateLabel.y = passY;
    self.passRateNode.y = self.passRateLabel.maxY + textGap;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
