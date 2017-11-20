//
//  DetailLogoCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailLogoCell.h"

@interface DetailLogoCell()

@property(nonatomic,retain) UIImageView* iconView;
@property(nonatomic,retain) ASDisplayNode* backNode;
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

-(ASDisplayNode *)backNode{
    if (!_backNode) {
        _backNode = [[ASDisplayNode alloc]init];
        _backNode.backgroundColor = [UIColor whiteColor];
        _backNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

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



@end
