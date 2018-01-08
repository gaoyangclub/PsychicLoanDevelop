//
//  UserHomeController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/28.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "UserHomeController.h"
#import "FlatButton.h"
#import "PopAnimateManager.h"
#import "NormalSelectItem.h"
#import "UserDefaultsUtils.h"
#import "CustomerServiceController.h"
#import "WebViewController.h"
#import "AppViewManager.h"
#import "MobClickEventManager.h"

typedef NS_ENUM(NSInteger,ItemPostion){
    ItemPostionNormal = 1,
    ItemPostionTop,
    ItemPostionBottom,
    ItemPostionSingle,
};

@interface UserHomeController ()

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIScrollView* scrollView;

@property(nonatomic,retain)NormalSelectItem* userBack;

@property(nonatomic,retain)ASTextNode* versionLabel;

@property(nonatomic,retain)FlatButton* logoutButton;

@end

@implementation UserHomeController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_USER superView:nil];
    }
    return _titleLabel;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(ASTextNode *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[ASTextNode alloc]init];
        _versionLabel.layerBacked = YES;
        _versionLabel.attributedText = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:[Config getVersionDescription]];
        [_versionLabel sizeToFit];
        [self.view.layer addSublayer:_versionLabel.layer];
    }
    return _versionLabel;
}

-(FlatButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [[FlatButton alloc]init];
//        _logoutButton.titleFontName = ICON_FONT_NAME;
        _logoutButton.titleColor = COLOR_PRIMARY;
        _logoutButton.fillColor = [UIColor whiteColor];
        _logoutButton.titleSize = SIZE_TEXT_PRIMARY;
        _logoutButton.title = @"退出登录";
        _logoutButton.cornerRadius = 0;
        [_logoutButton addTarget:self action:@selector(clickLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_logoutButton];
    }
    return _logoutButton;
}

-(NormalSelectItem *)userBack{
    if (!_userBack) {
        _userBack = [[NormalSelectItem alloc]init];
        _userBack.backgroundColor = [UIColor whiteColor];
//        _userBack.strokeColor = COLOR_LINE;
        //        _userBack.arrowSize = CGSizeMake(10, 22);
        _userBack.showIconImage = YES;
        _userBack.labelName = @"点击请登录";
        _userBack.labelSize = SIZE_NAVI_TITLE;
        _userBack.labelColor = COLOR_TEXT_PRIMARY;
        _userBack.iconMargin = rpx(15);
//        _userBack.iconName = ICON_WO_DE_SELECTED;
//        _userBack.iconSize = 36;
//        _userBack.iconBackColor = COLOR_PRIMARY;
        
//        _userBack.showLabel = NO;
        
        [_userBack setShowTouch:YES];
        [self.scrollView addSubview:_userBack];
        
        [_userBack addTarget:self action:@selector(clickUserArea:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBack;
}

-(void)clickUserArea:(UIView*)sender{
    if (![UserDefaultsUtils getObject:PHONE_KEY]) {//说明未登录
        [AppViewManager popLoginViewController];
    }
}

-(void)clickLogoutButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"退出账号？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
//    __weak __typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserDefaultsUtils removeObject:PHONE_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGOUT object:nil];//直接登出
//        [[OwnerViewController sharedInstance]logout:^{
//            [(GYTabBarController*)weakSelf.tabBarController valueCommit:0];//自动回到主页
//        }];
        [MobClickEventManager userLogoutClick];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)initNavigationItem{
    self.titleLabel.text = NAVIGATION_TITLE_USER;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;//[UIColor whiteColor];
}

#pragma 坑爹!!! 必须时时跟随主view的frame
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    
    CGFloat viewHeight = self.view.height;
    
    self.versionLabel.centerX = self.view.width / 2.;
    self.versionLabel.maxY = viewHeight - rpx(5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [self initNavigationItem];
    
    [self measure];
    
    [self checkLoginData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkLoginData)
                                                 name:EVENT_LOGOUT
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkLoginData)
                                                 name:EVENT_LOGIN_COMPLETE
                                               object:nil];
    
    [MobClickEventManager userViewControllerDidLoad];
}

-(void)measure{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat gap = rpx(5);
    
    CGFloat bottomY = gap;
    bottomY = [self initUserItem:bottomY];
    bottomY += gap;
    
    bottomY = [self initNormalItem:bottomY icon:ICON_LIAN_XI_KE_FU labal:@"联系客服" iconBackColor:COLOR_PRIMARY handler:@selector(clickContactCustomerHandler) itemPostion:ItemPostionTop];
    bottomY = [self initNormalItem:bottomY icon:ICON_WEN_TI_FAN_KUI labal:@"问题反馈" iconBackColor:COLOR_PRIMARY handler:@selector(clickQuestionFeedbackHandler)];
    bottomY = [self initNormalItem:bottomY icon:ICON_GUAN_YU_WO_MEN labal:@"关于我们" iconBackColor:COLOR_PRIMARY handler:@selector(clickAboutUsHandler) itemPostion:ItemPostionBottom];
    
    bottomY += gap;
    bottomY = [self initLogoutButton:bottomY];
    bottomY += gap;
    
    self.scrollView.contentSize = CGSizeMake(viewWidth, bottomY);
}

-(void)checkLoginData{
    NSString* userPhone = [UserDefaultsUtils getObject:PHONE_KEY];
    if (userPhone) {//说明已经登录
        self.userBack.labelName = userPhone;
        self.userBack.iconName = @"login_avatar";
        self.logoutButton.hidden = NO;
    }else{
        self.userBack.labelName = @"登录体验更多";
        self.userBack.iconName = @"logout_avatar";
        self.logoutButton.hidden = YES;
    }
}

-(void)clickContactCustomerHandler{//联系客服
    CustomerServiceController* customerServiceController = [[CustomerServiceController alloc]init];
    customerServiceController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:customerServiceController animated:YES];
}

-(void)clickQuestionFeedbackHandler{//问题反馈
    [AppViewManager openFeedbackViewController:self.navigationController];
    [MobClickEventManager userFeedbackClick];
}

-(void)clickAboutUsHandler{//关于我们
    WebViewController* viewController = [[WebViewController alloc]init];
    viewController.linkUrl = LINK_URL_ABOUT_US;
    viewController.navigationTitle = @"关于我们";
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(CGFloat)initLogoutButton:(CGFloat)bottomY{
    CGFloat buttonHeight = rpx(45);
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat padding = 0;
    
    self.logoutButton.frame = CGRectMake(padding, bottomY, viewWidth - padding * 2, buttonHeight);
    
    return bottomY + buttonHeight;
}

-(CGFloat)initUserItem:(CGFloat)bottomY{//用户数据条目
    CGFloat backHeight = rpx(100);
    self.userBack.frame = CGRectMake(0, bottomY, CGRectGetWidth(self.view.bounds), backHeight);
    return bottomY + backHeight;
}

-(CGFloat)initNormalItem:(CGFloat)bottomY icon:(NSString*)icon labal:(NSString*)label iconBackColor:(UIColor*)iconBackColor handler:(SEL)handler itemPostion:(ItemPostion)itemPostion{//用户数据条目
    CGFloat normalHeight = rpx(55);
    
    NormalSelectItem* normalItem = [[NormalSelectItem alloc]init];
    normalItem.backgroundColor = [UIColor whiteColor];
    normalItem.strokeColor = COLOR_LINE;
    //        _userBack.arrowSize = CGSizeMake(10, 22);
    normalItem.iconName = icon;
    normalItem.iconSize = rpx(20);
    normalItem.iconColor = handler ? iconBackColor : FlatGray;
    normalItem.iconBackColor = [UIColor clearColor];
    normalItem.showIconLine = NO;
    
    normalItem.labelName = label;
    normalItem.labelSize = SIZE_TEXT_PRIMARY;
    normalItem.labelColor = handler ? COLOR_TEXT_PRIMARY : COLOR_LINE;
    //    normalItem.lineLeftMargin = 50;
    if (itemPostion == ItemPostionTop) {
        normalItem.showTopLine = YES;
        normalItem.lineBottomLeftMargin = normalHeight;
    }else if (itemPostion == ItemPostionBottom) {
        normalItem.showTopLine = NO;
        normalItem.lineBottomLeftMargin = 0;
    }else if (itemPostion == ItemPostionNormal) {
        normalItem.showTopLine = NO;
        normalItem.lineBottomLeftMargin = normalHeight;
    }else if (itemPostion == ItemPostionSingle) {
        normalItem.showTopLine = YES;
        normalItem.lineBottomLeftMargin = 0;
    }
    
    [normalItem setShowTouch:YES];
    [self.scrollView addSubview:normalItem];
    
    normalItem.frame = CGRectMake(0, bottomY, CGRectGetWidth(self.view.bounds), normalHeight);
    
    [normalItem addTarget:self action:handler forControlEvents:UIControlEventTouchUpInside];
    
    return bottomY + normalHeight;
}

-(CGFloat)initNormalItem:(CGFloat)bottomY icon:(NSString*)icon labal:(NSString*)label iconBackColor:(UIColor*)iconBackColor handler:(SEL)handler{//用户数据条目
    return [self initNormalItem:bottomY icon:icon labal:label iconBackColor:iconBackColor handler:handler itemPostion:ItemPostionNormal];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGIN_COMPLETE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGOUT object:nil];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
