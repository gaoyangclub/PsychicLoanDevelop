//
//  WebViewController.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "MobClickEventManager.h"

@interface WebViewController()

@property(nonatomic,retain)WKWebView* webView;
@property(nonatomic,retain)UIProgressView* progressView;
@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)UIView* statusArea;

@end

@implementation WebViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        _webView.scrollView.bounces = false;
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

-(UIView *)statusArea{
    if (!_statusArea) {
        _statusArea = [[UIView alloc]init];
        _statusArea.backgroundColor = COLOR_PRIMARY;
        [self.view addSubview:_statusArea];
    }
    return _statusArea;
}

-(void)viewDidLayoutSubviews{
    CGFloat baseY = 0;
    if (self.soStatusBar) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        baseY = rectStatus.size.height;
        self.statusArea.frame = rectStatus;
    }
    self.webView.frame = CGRectMake(0, baseY, self.view.width, self.view.height - baseY);
//    self.view.bounds;
    self.progressView.frame = CGRectMake(0, baseY, self.view.width, rpx(3));
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
        [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = self.navigationTitle ? self.navigationTitle : @"";//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
//    [self.navigationController.navigationBar jk_setNavigationBarBackgroundColor:COLOR_PRIMARY];
//    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
}

//返回上层
-(void)leftClick{
    if (self.loanId) {
        __weak __typeof(self) weakSelf = self;
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定注册了吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"继续注册" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [MobClickEventManager webViewAlertClick:weakSelf.loanId isCancel:NO];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf popToPrevController];
            [MobClickEventManager webViewAlertClick:strongSelf.loanId isCancel:YES];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self popToPrevController];
    }
}

-(void)popToPrevController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];

//    if (self.hidesBottomBarWhenPushed) {
////        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    CGFloat viewHeight = self.view.height;
    self.webView.frame = self.view.bounds;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
    
    [self initNavigationItem];
    
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.linkUrl]]];
    if (self.loanId) {
        [MobClickEventManager webViewControllerDidLoad:self.loanId];
    }
}

@end
