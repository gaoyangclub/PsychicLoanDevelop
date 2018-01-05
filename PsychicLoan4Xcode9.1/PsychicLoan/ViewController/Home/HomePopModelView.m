//
//  HomePopModelView.m
//  PsychicLoan
//
//  Created by 高扬 on 17/12/2.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomePopModelView.h"
#import "UIImageView+WebCache.h"
#import "FlatButton.h"
#import "DetailViewController.h"
#import "AppViewManager.h"

@interface HomePopModelView()

@property(nonatomic,retain)UIImageView* bannerImageView;//弹窗推荐的图片
@property(nonatomic,retain)FlatButton* cancelButton;

@end

@implementation HomePopModelView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.topMargin = rpx(194);
        self.leftMargin = rpx(50);
    }
    return self;
}

-(UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc]init];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_bannerImageView];
    }
    return _bannerImageView;
}

-(FlatButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[FlatButton alloc]init];
        _cancelButton.titleFontName = ICON_FONT_NAME;
        _cancelButton.title = ICON_CLOSE;
        _cancelButton.titleSize = rpx(25);
        _cancelButton.fillColor = [UIColor clearColor];
        _cancelButton.titleColor = [UIColor whiteColor];//_cancelButton.strokeColor =
//        _cancelButton.strokeWidth = rpx(1.5);
        _cancelButton.cornerRadius = rpx(20);
        _cancelButton.size = CGSizeMake(_cancelButton.cornerRadius * 2, _cancelButton.cornerRadius * 2);
        [self.contentView addSubview:_cancelButton];
        
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(void)viewDidLoad{
    self.contentView.layer.cornerRadius = 0;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.popToDirection = self.popFromDirection = CustomPopDirectionCenter;
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:self.bannerModel.loanimg]];
    self.bannerImageView.frame = self.contentView.bounds;
    
    self.cancelButton.centerX = self.contentView.width / 2.;
    self.cancelButton.maxY = self.contentView.height;
    
    [self.contentView addTarget:self action:@selector(clickBackView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBackView{
    [self dismiss];
    
    DetailViewController* viewController = [[DetailViewController alloc]init];
    viewController.loanId = self.bannerModel.loanid;
    viewController.loanName = self.bannerModel.loanname;
    viewController.hidesBottomBarWhenPushed = YES;
    [[AppViewManager getCurrentNavigationController] pushViewController:viewController animated:YES];
}

@end
