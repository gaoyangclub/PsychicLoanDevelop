//
//  FlatButton.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IconAlignment) {
    IconAlignmentLeft = 0,
    IconAlignmentRight,
    IconAlignmentUp,
    IconAlignmentDown
};

@interface FlatButton : UIControl

@property(nonatomic,assign) CGFloat cornerRadius;

@property(nonatomic,copy) NSString* icon;
@property(nonatomic,retain) UIColor* iconColor;
//@property(nonatomic,retain) NSString* iconFontName;
@property(nonatomic,assign) CGFloat iconSize;
@property(nonatomic,assign) IconAlignment iconAlignment;
//icon对齐方式 左右(纵向居中)上下(横向居中)
@property(nonatomic,assign) CGFloat iconGap;//和文字之间的间距

@property(nonatomic,copy) NSString* title;
@property(nonatomic,retain) UIColor* titleColor;
@property(nonatomic,retain) NSString* titleFontName;
@property(nonatomic,assign) CGFloat titleSize;

@property(nonatomic,retain) UIColor* fillColor;
@property(nonatomic,retain) UIColor* strokeColor;
@property(nonatomic,assign) CGFloat strokeWidth;

@property(nonatomic,assign) CGFloat angle;//旋转角度


@end
