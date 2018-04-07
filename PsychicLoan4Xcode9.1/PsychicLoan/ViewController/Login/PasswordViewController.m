//
//  PasswordViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/12/1.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#define LEFT_MARGIN rpx(40)
#define INPUT_AREA_HEIGHT rpx(165)
#define INPUT_AREA_PADDING rpx(14)

#import "PasswordViewController.h"
#import "AuthCodeModel.h"
#import "FlatButton.h"
#import "LoginViewModel.h"
#import "UserDefaultsUtils.h"
#import "HudManager.h"
#import "PopAnimateManager.h"
#import "TimerUtils.h"
#import "MobClickEventManager.h"

@interface PasswordViewController (){
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

@property(nonatomic,retain)LoginViewModel* viewModel;

@end

@implementation PasswordViewController

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
        _passwordText.placeholder = ConcatStrings(@"请设置登录密码(不少于",@(AUTH_CODE_LENGTH),@"位)") ;
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
        _submitButton.title = @"重置密码并登录";
        _submitButton.cornerRadius = rpx(4);
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(void)initNavigationItem{
    self.titleLabel.text = NAVIGATION_TITLE_REGISTER;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
//    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;
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
    
    [SVProgressHUD showWithStatus:@"密码修改中..."];// maskType:SVProgressHUDMaskTypeBlack
    
    __weak __typeof(self) weakSelf = self;
    [self.viewModel updatePassword:phone password:password authCode:authcode authCodeBean:self->authCodeResult returnBlock:^(id returnValue) {
        __strong typeof(self) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [SVProgressHUD dismiss];
        
        [UserDefaultsUtils setObject:phone forKey:PHONE_KEY];//密码修改成功
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
        
        [strongSelf closeWindow];
        
        [MobClickEventManager loginComplete];
        
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        [HudManager showToast:errorMsg];
        
        [PopAnimateManager startShakeAnimation:sender];
    }];
}

-(void)checkCanLeaveThisPage:(void(^)())nextHandler{
    NSString* phone = self.usernameText.text;
    NSString* authcode = self.authcodeText.text;
    NSString* password = self.passwordText.text;
    if ((phone && phone.length > 0) || (authcode && authcode.length > 0) || (password && password.length > 0)) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有正在填入的数据，确定退出重置密码？退出后将不会保存！" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"继续重置" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            nextHandler();
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        nextHandler();
    }
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
    [self.viewModel getAuthCode:phone type:AuthCodeTypePassword returnBlock:^(AuthCodeModel* authCodeModel){
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
