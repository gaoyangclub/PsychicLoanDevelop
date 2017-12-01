//
//  FlatButton.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FlatButton.h"
#import "RoundRectNode.h"

@interface FlatButton()

@property(nonatomic,retain) RoundRectNode* backArea;
@property(nonatomic,retain) ASTextNode* iconNode;
@property(nonatomic,retain) ASTextNode* titleLabel;//去这里

@end

@implementation FlatButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

-(void)prepare{
    //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    self.titleColor = [UIColor whiteColor];
    self.fillColor = [UIColor grayColor];
    self.titleSize = 12;
    self.cornerRadius = 5;
//    self.angle = -30;
    self.title = @"";
    [self setShowTouch:YES];
}

-(void)setIcon:(NSString *)icon{
    _icon = icon;
    [self setNeedsLayout];
}

-(void)setIconColor:(UIColor *)iconColor{
    _iconColor = iconColor;
    [self setNeedsLayout];
}

-(void)setIconSize:(CGFloat)iconSize{
    _iconSize = iconSize;
    [self setNeedsLayout];
}

-(void)setIconAlignment:(IconAlignment)iconAlignment{
    _iconAlignment = iconAlignment;
    [self setNeedsLayout];
}

-(void)setIconGap:(CGFloat)iconGap{
    _iconGap = iconGap;
    [self setNeedsLayout];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setNeedsLayout];
}

-(void)setTitleSize:(CGFloat)titleSize{
    _titleSize = titleSize;
    [self setNeedsLayout];
}

-(void)setTitleFontName:(NSString *)titleFontName{
    _titleFontName = titleFontName;
    [self setNeedsLayout];
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsLayout];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

-(RoundRectNode *)backArea{
    if (!_backArea) {
        _backArea = [[RoundRectNode alloc]init];
        _backArea.layerBacked = YES;
        [self.layer addSublayer:_backArea.layer];
    }
    return _backArea;
}

-(ASTextNode *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.layer addSublayer:_titleLabel.layer];
    }
    return _titleLabel;
}

-(ASTextNode *)iconNode{
    if (!_iconNode) {
        _iconNode = [[ASTextNode alloc]init];
        _iconNode.layerBacked = YES;
        [self.layer addSublayer:_iconNode.layer];
    }
    return _iconNode;
}

-(void)layoutSubviews{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    self.backArea.cornerRadius = self.cornerRadius;
    self.backArea.strokeColor = self.strokeColor;
    self.backArea.strokeWidth = self.strokeWidth;
    self.backArea.fillColor = self.fillColor;
    self.backArea.frame = self.bounds;
    
    if(self.icon){
        self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.iconColor size:self.iconSize content:self.icon];
        self.iconNode.size = [self.iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    }
    if (self.titleFontName) {
        self.titleLabel.attributedString = [NSString simpleAttributedString:self.titleFontName color:self.titleColor  size:self.titleSize content:self.title];
    }else{
        self.titleLabel.attributedString = [NSString simpleAttributedString:self.titleColor  size:self.titleSize content:self.title];
    }
    self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    if (self.icon && self.titleLabel) {
        switch (self.iconAlignment) {
            case IconAlignmentLeft:
                self.iconNode.x = (viewWidth - self.iconNode.width - self.titleLabel.width - self.iconGap) / 2.;
                self.titleLabel.x = self.iconNode.maxX + self.iconGap;
                self.titleLabel.centerY = self.iconNode.centerY = viewHeight / 2.;
                break;
            case IconAlignmentRight:
                self.titleLabel.x = (viewWidth - self.iconNode.width - self.titleLabel.width - self.iconGap) / 2.;
                self.iconNode.x = self.titleLabel.maxX + self.iconGap;
                self.titleLabel.centerY = self.iconNode.centerY = viewHeight / 2.;
                break;
            case IconAlignmentUp:
                self.iconNode.y = (viewHeight - self.iconNode.height - self.titleLabel.height - self.iconGap) / 2.;
                self.titleLabel.y = self.iconNode.maxY + self.iconGap;
                self.titleLabel.centerX = self.iconNode.centerX = viewHeight / 2.;
                break;
            case IconAlignmentDown:
                self.titleLabel.y = (viewHeight - self.iconNode.height - self.titleLabel.height - self.iconGap) / 2.;
                self.iconNode.y = self.titleLabel.maxY + self.iconGap;
                self.titleLabel.centerX = self.iconNode.centerX = viewHeight / 2.;
                break;
            default:
                break;
        }
    }else{
        self.titleLabel.centerX = viewWidth / 2.;
        self.titleLabel.centerY = viewHeight / 2.;
    }
    
    if(self.angle){
        CATransform3D transform = CATransform3DMakeRotation(self.angle * M_PI / 180,0,0,1);
        self.backArea.transform = self.titleLabel.transform = transform;
    }
}


@end
