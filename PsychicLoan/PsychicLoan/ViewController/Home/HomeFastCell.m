//
//  HomeFastCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/17.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeFastCell.h"
#import "FlatButton.h"
#import "LoanTypeViewController.h"
#import "AppDelegate.h"

@interface HomeFastItem : UIControl

@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) FlatButton* imageNode;//图片文本

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* image;
@property(nonatomic,retain) UIColor* imageColor;

@end

static NSArray<NSNumber*>* loanTpyes;

@implementation HomeFastItem

+(void)load{
    loanTpyes = @[@(LOAN_TYPE_NEW),@(LOAN_TYPE_FAST),@(LOAN_TYPE_PASS)];
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(FlatButton *)imageNode{
    if (!_imageNode) {
        _imageNode = [[FlatButton alloc]init];
        _imageNode.titleFontName = ICON_FONT_NAME;
        _imageNode.titleColor = COLOR_PRIMARY;
        _imageNode.titleSize = rpx(30);
        _imageNode.fillColor = [UIColor clearColor];
//        _imageNode.cornerRadius = rpx(10);
        _imageNode.userInteractionEnabled = NO;
        [self addSubview:_imageNode];
    }
    return _imageNode;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(void)setImage:(NSString *)image{
    _image = image;
    [self setNeedsLayout];
}

-(void)setImageColor:(UIColor *)imageColor{
    _imageColor = imageColor;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.showTouch = YES;
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_SECONDARY content:self.title isBold:YES];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];

    self.imageNode.title = self.image;
//    self.imageNode.fillColor = self.imageColor;
    CGFloat const nodeSizeWidth = self.height - rpx(36);
    self.imageNode.size = CGSizeMake(nodeSizeWidth,nodeSizeWidth);
    
//    self.imageNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.imageColor size:36 content:self.image];
//    self.imageNode.size = [self.imageNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];

    self.titleNode.centerX = self.imageNode.centerX = self.width / 2.;
    CGFloat const gap = rpx(5);
    CGFloat const baseY = (self.height - self.titleNode.height - self.imageNode.height - gap) / 2;
    self.imageNode.y = baseY;
    self.titleNode.y = self.imageNode.maxY + gap;
}

@end


@implementation HomeFastCell

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
//    NSArray<UIColor*>* itemImageColors = @[FlatWatermelon,FlatOrange,FlatSkyBlue];
    NSArray<NSString*>* itemImages = @[ICON_FEN_XIANG,ICON_SHOU_ZHI,ICON_QIAN_DAO];
    
    CGFloat const itemWidth = self.contentView.width / loanTpyes.count;
    
    for (NSInteger i = 0; i < loanTpyes.count; i++) {
        HomeFastItem* item = [[HomeFastItem alloc]init];
        item.title = [Config getLoanTypeNameByCode:[loanTpyes[i] intValue]];
//        item.imageColor = itemImageColors[i];
        item.image = itemImages[i];
        [self.contentView addSubview:item];
        item.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.contentView.height);
        item.tag = i;
        [item addTarget:self action:@selector(fastItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)fastItemClick:(UIView*)sender{
    LoanTypeViewController* viewController = [[LoanTypeViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.loanType = [loanTpyes[sender.tag] intValue];
    [[AppDelegate getCurrentNavigationController]pushViewController:viewController animated:YES];
}

@end
