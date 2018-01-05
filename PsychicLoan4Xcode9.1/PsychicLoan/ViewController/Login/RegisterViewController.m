//
//  RegisterViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/29.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "RegisterViewController.h"
#import "FlatButton.h"
#import "HudManager.h"
#import "PopAnimateManager.h"
#import "WebViewController.h"
#import "LoginViewModel.h"
#import "AuthCodeModel.h"
#import "UserDefaultsUtils.h"
#import "TimerUtils.h"
#import "MobClickEventManager.h"

#define LEFT_MARGIN rpx(40)
#define INPUT_AREA_HEIGHT rpx(165)
#define INPUT_AREA_PADDING rpx(14)

@interface RegisterViewController (){
    AuthCodeModel* authCodeResult;
}

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIView* inputArea;
@property(nonatomic,retain)UITextField* usernameText;
@property(nonatomic,retain)UITextField* authcodeText;
@property(nonatomic,retain)UITextField* passwordText;
@property(nonatomic,retain)FlatButton* authcodeButton;
@property(nonatomic,retain)UIView* inputLineCenterY1;
@property(nonatomic,retain)UIView* inputLineCenterY2;

@property(nonatomic,retain)FlatButton* submitButton;
@property(nonatomic,retain)FlatButton* agreementButton;
@property(nonatomic,retain)FlatButton* loginButton;

@property(nonatomic,retain)LoginViewModel* viewModel;

@end

@implementation RegisterViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_REGISTER superView:nil];
    }
    return _titleLabel;
}

-(LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}

-(UIView *)inputArea{
    if (!_inputArea) {
        _inputArea = [[UIView alloc]init];
        _inputArea.backgroundColor = [UIColor whiteColor];
        _inputArea.layer.cornerRadius = rpx(4);
        _inputArea.layer.masksToBounds = YES;
        
        [self.view addSubview:_inputArea];
    }
    return _inputArea;
}

-(UITextField *)usernameText{
    if (!_usernameText) {
        _usernameText = [[UITextField alloc]init];
        _usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _usernameText.font = [UIFont systemFontOfSize:SIZE_TEXT_PRIMARY];
        _usernameText.textColor = COLOR_TEXT_PRIMARY;
        //        _usernameText.delegate = self; //文本交互代理
        _usernameText.placeholder = @"请输入手机号";
        _usernameText.keyboardType = UIKeyboardTypePhonePad;
        _usernameText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        [self.inputArea addSubview:_usernameText];
    }
    return _usernameText;
}

-(UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _passwordText.font = [UIFont systemFontOfSize:SIZE_TEXT_PRIMARY];
        _passwordText.textColor = COLOR_TEXT_PRIMARY;
        //        _usernameText.delegate = self; //文本交互代理
        _passwordText.placeholder = @"请设置登录密码(不少于六位)";
//        _passwordText.keyboardType = UIKeyboardTypePhonePad;
        _passwordText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        _passwordText.secureTextEntry = YES;
        [self.inputArea addSubview:_passwordText];
    }
    return _passwordText;
}

-(UIView *)inputLineCenterY1{
    if (!_inputLineCenterY1) {
        _inputLineCenterY1 = [[UIView alloc]init];
        _inputLineCenterY1.backgroundColor = COLOR_PRIMARY;
        [self.inputArea addSubview:_inputLineCenterY1];
    }
    return _inputLineCenterY1;
}

-(UIView *)inputLineCenterY2{
    if (!_inputLineCenterY2) {
        _inputLineCenterY2 = [[UIView alloc]init];
        _inputLineCenterY2.backgroundColor = COLOR_PRIMARY;
        [self.inputArea addSubview:_inputLineCenterY2];
    }
    return _inputLineCenterY2;
}

-(UITextField *)authcodeText{
    if (!_authcodeText) {
        _authcodeText = [[UITextField alloc]init];
        _authcodeText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _authcodeText.font = [UIFont systemFontOfSize:SIZE_TEXT_PRIMARY];
        _authcodeText.textColor = COLOR_TEXT_PRIMARY;
        //        _authcodeText.delegate = self; //文本交互代理
        _authcodeText.placeholder = @"请输入验证码";
        _authcodeText.keyboardType = UIKeyboardTypeNumberPad;
        _authcodeText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        [self.inputArea addSubview:_authcodeText];
    }
    return _authcodeText;
}

-(FlatButton *)authcodeButton{
    if (!_authcodeButton) {
        _authcodeButton = [[FlatButton alloc]init];
        _authcodeButton.title = @"发送验证码";
        _authcodeButton.titleSize = SIZE_TEXT_PRIMARY;
        _authcodeButton.titleColor = COLOR_PRIMARY;
        _authcodeButton.fillColor = [UIColor clearColor];
        _authcodeButton.width = rpx(90);
        _authcodeButton.y = _authcodeButton.height = INPUT_AREA_HEIGHT / 3.;
        
        UIView* leftLine = [[UIView alloc]init];
        leftLine.backgroundColor = COLOR_PRIMARY;
        leftLine.frame = CGRectMake(0, INPUT_AREA_PADDING, LINE_WIDTH, _authcodeButton.height - INPUT_AREA_PADDING * 2);
        [_authcodeButton addSubview:leftLine];
        
        [self.inputArea addSubview:_authcodeButton];
        
        [_authcodeButton addTarget:self action:@selector(clickAuthcodeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authcodeButton;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        //        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.strokeColor = [UIColor whiteColor];
        _submitButton.strokeWidth = LINE_WIDTH;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = SIZE_TEXT_LARGE;
        _submitButton.title = @"注    册";
        _submitButton.cornerRadius = rpx(4);
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(FlatButton *)agreementButton{
    if (!_agreementButton) {
        _agreementButton = [[FlatButton alloc]init];
        _agreementButton.fillColor = [UIColor clearColor];
        _agreementButton.titleSize = SIZE_TEXT_PRIMARY;
        _agreementButton.title = ConcatStrings(@"同意 <<",APPLICATION_NAME,@"注册协议>>");
        _agreementButton.icon = ICON_DA_GOU;
        _agreementButton.iconColor = [UIColor whiteColor];
        _agreementButton.iconSize = rpx(16);
        _agreementButton.iconGap = rpx(8);
        [_agreementButton addTarget:self action:@selector(clickAgreementButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_agreementButton];
    }
    return _agreementButton;
}

-(FlatButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[FlatButton alloc]init];
        _loginButton.fillColor = [UIColor clearColor];
        _loginButton.titleSize = SIZE_TEXT_PRIMARY;
        _loginButton.title = @"已有账号，去登录";
        [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

-(void)initNavigationItem{
    self.titleLabel.text = NAVIGATION_TITLE_REGISTER;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:SIZE_TEXT_PRIMARY] text:@"关闭" target:self action:@selector(clickClose)];
}

//返回上层
-(void)leftClick{
    __weak __typeof(self) weakSelf = self;
    [self checkCanLeaveThisPage:^{
        [weakSelf popToPrevController];
    }];
}

-(void)clickClose{
    __weak __typeof(self) weakSelf = self;
    [self checkCanLeaveThisPage:^{
        [weakSelf closeWindow];
    }];
}

-(void)closeWindow{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)popToPrevController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self initInputArea];
    [self initButtonArea];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_PRIMARY;
    
    [self initNavigationItem];
    
    [MobClickEventManager registerViewControllerDidLoad];
}

-(void)initInputArea{
    CGFloat const padding = INPUT_AREA_PADDING;
    
    CGFloat const viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat const inputHeight = INPUT_AREA_HEIGHT / 3.;
    CGFloat const areaWidth = viewWidth - LEFT_MARGIN * 2;
    
    self.inputArea.size = CGSizeMake(areaWidth, INPUT_AREA_HEIGHT);
    self.inputArea.x = LEFT_MARGIN;
    self.inputArea.maxY = self.view.height / 2.;
    
    self.usernameText.frame = CGRectMake(padding, 0, areaWidth - padding * 2, inputHeight);
    
    self.inputLineCenterY1.frame = CGRectMake(0, inputHeight, areaWidth, LINE_WIDTH);
    
    self.authcodeButton.maxX = areaWidth;
    
    self.authcodeText.frame = CGRectMake(padding, inputHeight, areaWidth - self.authcodeButton.width - padding * 2, inputHeight);
    
    self.inputLineCenterY2.frame = CGRectMake(0, inputHeight * 2, areaWidth, LINE_WIDTH);
    
    self.passwordText.frame = CGRectMake(padding, inputHeight * 2, areaWidth - padding * 2, inputHeight);
}

-(void)initButtonArea{
    CGFloat const inputGap = rpx(39);
    
    CGFloat const submitHeight = rpx(40);
    
    self.submitButton.frame = CGRectMake(LEFT_MARGIN, self.inputArea.maxY + inputGap, self.view.width - LEFT_MARGIN * 2, submitHeight);
    
    self.agreementButton.size = self.loginButton.size = CGSizeMake(self.view.width - LEFT_MARGIN * 2, submitHeight);
    
    self.agreementButton.centerX = self.loginButton.centerX = self.view.width / 2.;
    self.loginButton.maxY = self.view.height - inputGap;
    self.agreementButton.maxY = self.loginButton.y - rpx(70);
}

-(void)clickSubmitButton:(UIView*)sender{
    //    [[PopAnimateManager sharedInstance]startClickAnimation:sender];
    
    NSString* phone = self.usernameText.text;
    NSString* authcode = self.authcodeText.text;
    NSString* password = self.passwordText.text;
    
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    if (!authcode || authcode.length != AUTH_CODE_LENGTH) {
        [HudManager showToast:ConcatStrings(@"请输入",@(AUTH_CODE_LENGTH),@"位的验证码!")];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    if (!password || authcode.length < 6) {
        [HudManager showToast:@"请输入不小于6位密码!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"注册中..."];// maskType:SVProgressHUDMaskTypeBlack
    
    __weak __typeof(self) weakSelf = self;
    [self.viewModel registerAccount:phone password:password authCode:authcode authCodeBean:self->authCodeResult returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [SVProgressHUD dismiss];
        
        [UserDefaultsUtils setObject:phone forKey:PHONE_KEY];//注册成功
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
        
        [MobClickEventManager registerComplete];
        [MobClickEventManager loginComplete];
        
        [weakSelf closeWindow];
        
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        [HudManager showToast:errorMsg];
        
        [PopAnimateManager startShakeAnimation:sender];
    }];
}

-(void)clickAgreementButton:(UIView*)sender{
    WebViewController* viewController = [[WebViewController alloc]init];
//    viewController.hidesBottomBarWhenPushed = YES;
    viewController.linkUrl = LINK_URL_AGREEMENT;
    viewController.navigationTitle = ConcatStrings(APPLICATION_NAME,@"注册协议");
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)checkCanLeaveThisPage:(void(^)())nextHandler{
    NSString* phone = self.usernameText.text;
    NSString* authcode = self.authcodeText.text;
    NSString* password = self.passwordText.text;
    if ((phone && phone.length > 0) || (authcode && authcode.length > 0) || (password && password.length > 0)) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有正在填入的数据，确定退出注册？退出后将不会保存！" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"继续注册" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            nextHandler();
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        nextHandler();
    }
}

-(void)clickLoginButton:(UIView*)sender{
    __weak __typeof(self) weakSelf = self;
    [self checkCanLeaveThisPage:^{
        [weakSelf popToPrevController];
    }];
}

-(void)clickAuthcodeButton:(UIView*)sender{
    NSString* phone = self.usernameText.text;
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }else{
        [PopAnimateManager startClickAnimation:sender];
    }
    [self startCountDown];
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getAuthCode:phone type:AuthCodeTypeRegister returnBlock:^(AuthCodeModel* authCodeModel){
        __strong typeof(self) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        strongSelf->authCodeResult = authCodeModel;
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [HudManager showToast:errorMsg];
    }];
}

-(void)startCountDown{
    self.authcodeButton.titleColor = FlatGray;//置灰
    self.authcodeButton.userInteractionEnabled = NO;//无法交互
    
    __weak __typeof(self) weakSelf = self;
    [TimerUtils startCountDown:MAX_TIMER_COUNT_DOWN timeInterval:1 countDownHander:^(NSInteger countDownSecond) {
        weakSelf.authcodeButton.title = ConcatStrings(@"",@(countDownSecond),@"s后重发");
    } completeHander:^{
        [weakSelf endCountDown];
    }];
    
    self.authcodeButton.title = ConcatStrings(@"",@(MAX_TIMER_COUNT_DOWN),@"s后重发");
}

-(void)endCountDown{
    self.authcodeButton.title = @"发送验证码";
    self.authcodeButton.titleColor = COLOR_PRIMARY;//恢复颜色
    self.authcodeButton.userInteractionEnabled = YES;//恢复交互
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
