//
//  DetailTitleSection.m
//  PsychicLoan
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailTitleSection.h"

@interface DetailTitleSection()

@property(nonatomic,retain) ASDisplayNode* square;
@property(nonatomic,retain) ASTextNode* titleNode;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;

@end

@implementation DetailTitleSection

-(ASDisplayNode *)square{
    if (!_square) {
        _square = [[ASDisplayNode alloc]init];
        _square.backgroundColor = COLOR_PRIMARY;
        _square.layerBacked = YES;
        [self.layer addSublayer:_square.layer];
    }
    return _square;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
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

-(void)layoutSubviews{
    NSString* title = self.data;
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat const titleGap = rpx(4);
    
    self.square.frame = CGRectMake(0, 0, rpx(4), self.height);
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_SECONDARY size:SIZE_TEXT_SECONDARY content:title];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleNode.centerY = self.height / 2.;
    self.titleNode.x = self.square.maxX + titleGap;
    
    self.lineBottomY.frame = CGRectMake(0, self.height - LINE_WIDTH, self.width, LINE_WIDTH);
}


@end