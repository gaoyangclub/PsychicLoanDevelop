//
//  DetailMaterialCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailMaterialCell.h"
#import "LoanDetailModel.h"

@interface DetailMaterialCell()

@property (nonatomic,retain) ASTextNode* textStart;//描述文字

@end


@implementation DetailMaterialCell

-(ASTextNode *)textStart{
    if (!_textStart) {
        _textStart = [[ASTextNode alloc]init];
        _textStart.maximumNumberOfLines = 0;//无限伸展
        _textStart.truncationMode = NSLineBreakByTruncatingTail;
        _textStart.layerBacked = YES;
        [self.contentView.layer addSublayer:_textStart.layer];
    }
    return _textStart;
}

-(CGFloat)getCellHeight:(CGFloat)cellWidth{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat const topMargin = rpx(10);
    
    LoanDetailModel* detailModel = self.data;
    if (!detailModel.information) {
        return topMargin * 2;
    }
    CGFloat const leftMargin = rpx(20);
    
    NSArray *array = [detailModel.information componentsSeparatedByString:@";"];//--分隔符
    NSString* detailInfo = [array componentsJoinedByString:@"\n"];
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:detailInfo];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    style.lineSpacing = rpx(5);
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, detailInfo.length)];
    
    self.textStart.attributedString = textString;
    self.textStart.size = [self.textStart measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.textStart.x = leftMargin;
    self.textStart.y = topMargin;
    
    return self.textStart.maxY + topMargin;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
