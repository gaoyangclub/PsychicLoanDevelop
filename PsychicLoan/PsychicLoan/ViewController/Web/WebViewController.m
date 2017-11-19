//
//  WebViewController.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController()

@property(nonatomic,retain)WKWebView* webView;
@property(nonatomic,retain)UIProgressView* progressView;
@property(nonatomic,retain)UILabel* titleLabel;

@end

@implementation WebViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_WEB superView:nil];
    }
    return _titleLabel;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        __weak __typeof(self) weakSelf = self;
        [[_webView rac_valuesAndChangesForKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew observer:nil]subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.progressView.hidden = strongSelf->_webView.estimatedProgress == 1;
            [strongSelf.progressView setProgress:strongSelf->_webView.estimatedProgress animated:YES];
        }];
        [self.view addSubview:_webView];
    }
    return _webView;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

-(void)viewDidLayoutSubviews{
    self.webView.frame = self.view.bounds;
    self.progressView.frame = CGRectMake(0, 0, self.view.width, rpx(3));
}


-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
        [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = NAVIGATION_TITLE_WEB;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
//    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
}

//返回上层
-(void)leftClick{
    __weak __typeof(self) weakSelf = self;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定注册了吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"继续注册" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf popToPrevController];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)popToPrevController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];

    [self initNavigationItem];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
    
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.linkUrl]]];
}

@end
