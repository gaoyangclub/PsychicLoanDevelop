//
//  DetailBasicCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailBasicCell.h"
#import "LoanDetailModel.h"
#import "MeasureUnitConvert.h"

@interface DetailBasicCell()

@property(nonatomic,retain) ASTextNode* amountLabel;//借款额度
@property(nonatomic,retain) ASTextNode* amountNode;
@property(nonatomic,retain) ASTextNode* rateLabel;//日利率
@property(nonatomic,retain) ASTextNode* rateNode;
@property(nonatomic,retain) ASTextNode* timeLabel;//最小~最大期数
@property(nonatomic,retain) ASTextNode* timeNode;
@property(nonatomic,retain) ASDisplayNode* centerLineX1;//中心竖线
@property(nonatomic,retain) ASDisplayNode* centerLineX2;//中心竖线

@end

@implementation DetailBasicCell

-(ASTextNode *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[ASTextNode alloc]init];
        _amountLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_amountLabel.layer];
        _amountLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"借款额度"];
        [_amountLabel sizeToFit];
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

-(ASTextNode *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [[ASTextNode alloc]init];
        _rateLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_rateLabel.layer];
        _rateLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"日利率(%)"];
        [_rateLabel sizeToFit];
    }
    return _rateLabel;
}

-(ASTextNode *)rateNode{
    if (!_rateNode) {
        _rateNode = [[ASTextNode alloc]init];
        _rateNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_rateNode.layer];
    }
    return _rateNode;
}

-(ASTextNode *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[ASTextNode alloc]init];
        _timeLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_timeLabel.layer];
        _timeLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:@"借款期限"];
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

-(ASTextNode *)timeNode{
    if (!_timeNode) {
        _timeNode = [[ASTextNode alloc]init];
        _timeNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_timeNode.layer];
    }
    return _timeNode;
}

-(ASDisplayNode *)centerLineX1{
    if (!_centerLineX1) {
        _centerLineX1 = [[ASDisplayNode alloc]init];
        _centerLineX1.backgroundColor = COLOR_LINE;
//        _centerLineX1.width = LINE_WIDTH;
        _centerLineX1.layerBacked = YES;
        [self.contentView.layer addSublayer:_centerLineX1.layer];
    }
    return _centerLineX1;
}

-(ASDisplayNode *)centerLineX2{
    if (!_centerLineX2) {
        _centerLineX2 = [[ASDisplayNode alloc]init];
        _centerLineX2.backgroundColor = COLOR_LINE;
//        _centerLineX2.width = LINE_WIDTH;
        _centerLineX2.layerBacked = YES;
        [self.contentView.layer addSublayer:_centerLineX2.layer];
    }
    return _centerLineX2;
}

-(void)showSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    LoanDetailModel* detailModel = GET_CELL_DATA(LoanDetailModel.class);
    
    CGFloat const areaWidth = self.width / 3.;
    
    
    self.amountNode.attributedText = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:ConcatStrings([MeasureUnitConvert amountConvert:detailModel.minamount],@"~",[MeasureUnitConvert amountConvert:detailModel.maxamount])];
    [self.amountNode sizeToFit];
    
    self.rateNode.attributedText = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:detailModel.rate];
    [self.rateNode sizeToFit];
    
    self.timeNode.attributedText = [NSString simpleAttributedString:COLOR_PRIMARY size:SIZE_TEXT_PRIMARY content:
                                      ConcatStrings(@"",@(detailModel.mintime),@"~",@(detailModel.maxtime),@"天")];
    [self.timeNode sizeToFit];
    
//    CGFloat const topMargin = 0;
    CGFloat const nodeGap = rpx(5);
    CGFloat const amountBaseY = (self.height - self.amountLabel.height - self.amountNode.height - nodeGap) / 2.;
    self.amountLabel.centerX = self.amountNode.centerX = areaWidth / 2.;
    self.amountLabel.y = amountBaseY;
    self.amountNode.y = self.amountLabel.maxY + nodeGap;
    
    self.centerLineX1.frame = CGRectMake(areaWidth, 0, LINE_WIDTH, self.height);
    
    CGFloat const rateBaseY = (self.height - self.rateLabel.height - self.rateNode.height - nodeGap) / 2.;
    self.rateLabel.centerX = self.rateNode.centerX = areaWidth + areaWidth / 2.;
    self.rateLabel.y = rateBaseY;
    self.rateNode.y = self.rateLabel.maxY + nodeGap;
    
    self.centerLineX2.frame = CGRectMake(areaWidth * 2, 0, LINE_WIDTH, self.height);
    
    CGFloat const timeBaseY = (self.height - self.timeLabel.height - self.timeNode.height - nodeGap) / 2.;
    self.timeLabel.centerX = self.timeNode.centerX = areaWidth * 2 + areaWidth / 2.;
    self.timeLabel.y = timeBaseY;
    self.timeNode.y = self.timeLabel.maxY + nodeGap;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
