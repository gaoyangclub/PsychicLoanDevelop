//
//  DetailViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailViewController.h"
#import "FlatButton.h"

@interface DetailViewController ()

@property(nonatomic,retain)FlatButton* submitButton;

@end

@implementation DetailViewController

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = rpx(16);
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(void)clickSubmitButton:(UIView*)sender{
    
}

-(CGRect)getTableViewFrame{
    CGFloat const BUTTON_AREA_HEIGHT = rpx(55);
    CGFloat const margin = rpx(4);
    
    CGFloat const viewWidth = self.view.width;
    CGFloat const viewHeight = self.view.height;
    
    self.submitButton.frame = CGRectMake(margin, viewHeight - BUTTON_AREA_HEIGHT + margin, viewWidth - margin * 2, BUTTON_AREA_HEIGHT - margin * 2);
    
    return CGRectMake(margin, 0, viewWidth - margin * 2, viewHeight - BUTTON_AREA_HEIGHT);
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
