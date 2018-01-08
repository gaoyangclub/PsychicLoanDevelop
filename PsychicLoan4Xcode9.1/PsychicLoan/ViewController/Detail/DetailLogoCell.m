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
#import "MeasureUnitConvert.h"

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
        _titleNode.maximumNumberOfLines = 1;
        _titleNode.truncationMode = NSLineBreakByTruncatingTail;
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
        _describeNode.maximumNumberOfLines = 1;
        _describeNode.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_describeNode.layer];
    }
    return _describeNode;
}

-(ASTextNode *)passRateLabel{
    if (!_passRateLabel) {
        _passRateLabel = [[ASTextNode alloc]init];
        _passRateLabel.layerBacked = YES;
        _passRateLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"通过率"];
        [_passRateLabel sizeToFit];
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
    
    CGFloat const baseX = self.iconView.maxX + leftMargin;
    CGFloat const maxRightWidth = rpx(83);
    CGFloat const maxTitleWidth = self.contentView.width - baseX - maxRightWidth - leftMargin;
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_LARGE content:loanModel.loanname];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;//左对齐
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, loanModel.loanname.length)];
    
    self.titleNode.attributedText = textString;
    self.titleNode.size = [self.titleNode sizeThatFits:CGSizeMake(maxTitleWidth, FLT_MAX)];
    
    self.amountNode.attributedText = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_PRIMARY content:
                                        ConcatStrings(@"放款时间:",[MeasureUnitConvert timeConvert:loanModel.time])];
//                                        [NSString stringWithFormat:@"%ld",loanModel.maxamount]];
    [self.amountNode sizeToFit];
    
    textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:loanModel.loandes];
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, loanModel.loanname.length)];
    self.describeNode.attributedText = textString;
    self.describeNode.size = [self.describeNode sizeThatFits:CGSizeMake(maxTitleWidth, FLT_MAX)];
    
    self.titleNode.x = self.amountNode.x = self.describeNode.x = baseX;
    
    CGFloat const baseY = (self.height - self.titleNode.height - self.amountNode.height - self.describeNode.height - textGap * 2) / 2.;
    self.titleNode.y = baseY;
    self.amountNode.y = self.titleNode.maxY + textGap;
    self.describeNode.y = self.amountNode.maxY + textGap;
    
    self.passRateNode.attributedText = [NSString simpleAttributedString:FlatRed size:rpx(24) content:ConcatStrings(loanModel.passrate,@"%")];
    [self.passRateNode sizeToFit];
    
    CGFloat const passY = (self.height - self.passRateLabel.height - self.passRateNode.height - textGap) / 2.;
    
    self.passRateLabel.x = self.passRateNode.x = self.contentView.width - maxRightWidth;
    self.passRateLabel.y = passY;
    self.passRateNode.y = self.passRateLabel.maxY + textGap;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
