//
//  DetailBasicCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailBasicCell.h"
#import "LoanDetailModel.h"

@interface DetailBasicCell()

@property(nonatomic,retain) ASTextNode* amountLabel;//借款额度
@property(nonatomic,retain) ASTextNode* amountNode;
@property(nonatomic,retain) ASTextNode* rateNode;//日利率
@property(nonatomic,retain) ASTextNode* timeNode;//最小~最大期数
@property(nonatomic,retain) ASDisplayNode* centerLine;//中心竖线

@end

@implementation DetailBasicCell

-(ASTextNode *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[ASTextNode alloc]init];
        _amountLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_amountLabel.layer];
        _amountLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:@"借款额度"];
        _amountLabel.size = [_amountLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    }
    return _amountLabel;
}

-(ASTextNode *)amountNode{
    if (!_amountNode) {
        _amountNode = [[ASTextNode alloc]init];
        _amountNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_amountNode.layer];
    }
    return _amountNode;
}

-(ASTextNode *)rateNode{
    if (!_rateNode) {
        _rateNode = [[ASTextNode alloc]init];
        _rateNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_rateNode.layer];
    }
    return _rateNode;
}

-(ASTextNode *)timeNode{
    if (!_timeNode) {
        _timeNode = [[ASTextNode alloc]init];
        _timeNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_timeNode.layer];
    }
    return _timeNode;
}

-(ASDisplayNode *)centerLine{
    if (!_centerLine) {
        _centerLine = [[ASDisplayNode alloc]init];
        _centerLine.backgroundColor = COLOR_LINE;
        _centerLine.width = LINE_WIDTH;
        _centerLine.layerBacked = YES;
        [self.contentView.layer addSublayer:_centerLine.layer];
    }
    return _centerLine;
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    LoanDetailModel* detailModel = self.data;
    
    self.amountNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:ConcatStrings(@"",@(detailModel.minamount),@"~",@(detailModel.maxamount),@"万")];
    self.amountNode.size = [self.amountNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.rateNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:
                                      ConcatStrings(@"日利率:",detailModel.rate,@"%")];
    self.rateNode.size = [self.rateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.timeNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:
                                      ConcatStrings(@"期数:",@(detailModel.mintime),@"~",@(detailModel.maxtime),@"天")];
    self.timeNode.size = [self.timeNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat const leftMargin = rpx(20);
    CGFloat const nodeGap = rpx(5);
    CGFloat const amountBaseY = (self.height - self.amountLabel.height - self.amountNode.height - nodeGap) / 2.;
    self.amountLabel.x = self.amountNode.x = leftMargin;
    self.amountLabel.y = amountBaseY;
    self.amountNode.y = self.amountLabel.maxY + nodeGap;
    
    self.centerLine.height = self.height - leftMargin;
    self.centerLine.y = leftMargin / 2.;
    self.centerLine.x = self.amountNode.maxX + leftMargin * 2;
    
    CGFloat const rateBaseY = (self.height - self.rateNode.height - self.timeNode.height - nodeGap) / 2.;
    self.rateNode.x = self.timeNode.x = self.centerLine.maxX + leftMargin * 2;
    self.rateNode.y = rateBaseY;
    self.timeNode.y = self.rateNode.maxY + nodeGap;
    
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
