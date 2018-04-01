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
#import "WebViewController.h"
#import "AppViewManager.h"
#import "MobClickEventManager.h"
#import "MeasureUnitConvert.h"

@interface LoanNormalCell()

@property(nonatomic,retain) UIImageView* iconView;
//@property(nonatomic,retain) ASDisplayNode* backNode;
@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) ASTextNode* amountNode;
@property(nonatomic,retain) ASTextNode* describeNode;
@property(nonatomic,retain) FlatButton* linkButton;//跳转链接
@property(nonatomic,retain) ASDisplayNode* lineBottomY;

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

-(FlatButton *)linkButton{
    if (!_linkButton) {
        _linkButton = [[FlatButton alloc]init];
        _linkButton.strokeColor = COLOR_PRIMARY;
        _linkButton.strokeWidth = LINE_WIDTH;
        _linkButton.cornerRadius = rpx(4);
        _linkButton.fillColor = [UIColor whiteColor];
        _linkButton.titleColor = COLOR_PRIMARY;
        _linkButton.title = @"马上借钱";
        _linkButton.titleSize = SIZE_TEXT_PRIMARY;
        _linkButton.size = CGSizeMake(rpx(78), rpx(30));
        [self.contentView addSubview:_linkButton];
        [_linkButton addTarget:self action:@selector(clickLinkButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkButton;
}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.layer addSublayer:_lineBottomY.layer];
    }
    return _lineBottomY;
}

-(void)clickLinkButton:(UIView*)sender{
    LoanModel* loanModel = GET_CELL_DATA(LoanModel.class);
//    WebViewController* viewController = [[WebViewController alloc\]init];
//    viewController.navigationTitle = loanModel.loanname;
//    viewController.isLoanRegister = YES;
//    viewController.hidesBottomBarWhenPushed = YES;
//    viewController.linkUrl = ((LoanModel*)self.data).loanurl;
//    [[AppViewManager getCurrentNavigationController]pushViewController:viewController animated:YES];
    
    [AppViewManager popLoginNextWebController:loanModel navigationController:[AppViewManager getCurrentNavigationController]];
    
    [MobClickEventManager loanTypeClickByEvent:self.cellVo.cellName loanid:loanModel.loanid isLink:YES];
}

-(void)showSubviews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    LoanModel* loanModel = GET_CELL_DATA(LoanModel.class);
    
    CGFloat const leftMargin = rpx(10);
    
//    self.backNode.frame = CGRectMake(leftMargin, 0, self.contentView.width - leftMargin * 2, self.contentView.height);
    
    CGFloat const iconWidth = self.contentView.height - leftMargin * 2;
    self.iconView.size = CGSizeMake(iconWidth, iconWidth);
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = leftMargin;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:loanModel.loanlogo]];
    
    self.linkButton.centerY = self.contentView.height / 2.;
    self.linkButton.maxX = self.contentView.width - leftMargin;
    
    CGFloat const textGap = rpx(3);
    
    CGFloat const baseX = self.iconView.maxX + leftMargin;
    CGFloat const maxRightWidth = self.contentView.width - self.linkButton.x;
    CGFloat const maxTitleWidth = self.contentView.width - baseX - maxRightWidth - leftMargin;
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_LARGE content:loanModel.loanname];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;//左对齐
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, loanModel.loanname.length)];
    self.titleNode.attributedText = textString;
    self.titleNode.size = [self.titleNode sizeThatFits:CGSizeMake(maxTitleWidth, FLT_MAX)];
    
    NSString* timeStr = [MeasureUnitConvert timeConvert:loanModel.time];
    
    self.amountNode.attributedText = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:
                                        ConcatStrings([MeasureUnitConvert amountConvert:loanModel.maxamount],@" | ",timeStr)
                                        ];
//                                        [NSString stringWithFormat:@"%ld",loanModel.maxamount]];
    [self.amountNode sizeToFit];
    
    textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_SECONDARY content:loanModel.loandes];
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, loanModel.loandes.length)];
    self.describeNode.attributedText = textString;
    self.describeNode.size = [self.describeNode sizeThatFits:CGSizeMake(maxTitleWidth, FLT_MAX)];
    
    self.titleNode.x = self.amountNode.x = self.describeNode.x = baseX;
    
    CGFloat const baseY = (self.height - self.titleNode.height - self.amountNode.height - self.describeNode.height - textGap * 2) / 2.;
    self.titleNode.y = baseY;
    self.amountNode.y = self.titleNode.maxY + textGap;
    self.describeNode.y = self.amountNode.maxY + textGap;
    
    if (!self.isLast) {
        self.lineBottomY.frame = CGRectMake(0, self.height - LINE_WIDTH, self.width, LINE_WIDTH);
        self.lineBottomY.hidden = NO;
    }else if(self->_lineBottomY){
        self.lineBottomY.hidden = YES;
    }
    
}

//-(BOOL)showSelectionStyle{
//    return NO;
//}


@end
