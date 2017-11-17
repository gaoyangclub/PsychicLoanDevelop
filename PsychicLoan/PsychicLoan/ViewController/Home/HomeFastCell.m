//
//  HomeFastCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/17.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeFastCell.h"

@interface HomeFastItem : UIControl

@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) ASTextNode* imageNode;//图片文本

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* image;
@property(nonatomic,retain) UIColor* imageColor;

@end
@implementation HomeFastItem

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)imageNode{
    if (!_imageNode) {
        _imageNode = [[ASTextNode alloc]init];
        _imageNode.layerBacked = YES;
        [self.layer addSublayer:_imageNode.layer];
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
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:rpx(12) content:self.title];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];

    self.imageNode.attributedString = [NSString simpleAttributedString:self.imageColor size:36 content:self.image];
    self.imageNode.size = [self.imageNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//:ICON_FONT_NAME color

    self.titleNode.centerX = self.imageNode.centerX = self.width / 2.;
    CGFloat baseY = (self.height - self.titleNode.height - self.imageNode.height) / 2;
    self.imageNode.y = baseY;
    self.titleNode.y = self.imageNode.maxY;
}


@end


@implementation HomeFastCell

-(void)showSubviews{
    NSArray<NSString*>* itemTitles = @[@"新品专区",@"极速赚钱",@"高通过率"];
    NSArray<UIColor*>* itemImageColors = @[FlatMint,FlatOrange,FlatSkyBlue];
    NSArray<NSString*>* itemImages = @[@"\U00003605",@"\U00003605",@"\U00003605"];
    
    CGFloat const itemWidth = self.contentView.width / itemTitles.count;
    
    for (NSInteger i = 0; i < itemTitles.count; i++) {
        HomeFastItem* item = [[HomeFastItem alloc]init];
        item.title = itemTitles[i];
        item.imageColor = itemImageColors[i];
        item.image = itemImages[i];
        [self.contentView addSubview:item];
        item.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.contentView.height);
    }
}

@end
