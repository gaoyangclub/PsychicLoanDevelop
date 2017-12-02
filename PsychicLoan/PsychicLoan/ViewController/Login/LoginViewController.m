//
//  LoginViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/28.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoginViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "PPiFlatSegmentItem.h"
#import "FlatButton.h"
#import "HudManager.h"
#import "PopAnimateManager.h"
#import "RegisterViewController.h"
#import "LoginViewModel.h"
#import "AuthCodeModel.h"
#import "UserDefaultsUtils.h"
#import "TimerUtils.h"
#import "PasswordViewController.h"

#define LEFT_MARGIN rpx(40)
#define INPUT_AREA_HEIGHT rpx(110)
#define INPUT_AREA_PADDING rpx(14)

@interface LoginViewController (){
//    NSTimer* timer;
//    NSInteger countDownSecond;
    AuthCodeModel* authCodeResult;
}

@property(nonatomic,retain)PPiFlatSegmentedControl* segmentedControl;
@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIView* inputArea;
@property(nonatomic,retain)ASTextNode* usernameIcon;
@property(nonatomic,retain)UITextField* usernameText;
@property(nonatomic,retain)ASTextNode* authcodeIcon;
@property(nonatomic,retain)UITextField* authcodeText;
@property(nonatomic,retain)FlatButton* authcodeButton;
@property(nonatomic,retain)UIView* inputLineCenterY;

@property(nonatomic,retain)FlatButton* submitButton;
@property(nonatomic,retain)FlatButton* forgetButton;
@property(nonatomic,retain)FlatButton* registerButton;

@property(nonatomic,retain)LoginViewModel* viewModel;

@end

@implementation LoginViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_LOGIN superView:nil];
    }
    return _titleLabel;
}

-(LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}

-(PPiFlatSegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        NSArray* items = @[
                           [[PPiFlatSegmentItem alloc]initWithTitle:@"验证码登陆" andIcon:nil],
                           [[PPiFlatSegmentItem alloc]initWithTitle:@"密码登陆" andIcon:nil]
                           ];
        _segmentedControl = [[PPiFlatSegmentedControl alloc]initWithFrame:CGRectZero items:items iconPosition:IconPositionRight iconSeparation:0 target:self andSelection:@selector(segmentedControlSelected:)];
        [self.view addSubview:_segmentedControl];
        
        _segmentedControl.cornerRadius = rpx(4);
        _segmentedControl.borderWidth = LINE_WIDTH;
        _segmentedControl.borderColor = [UIColor whiteColor];
        _segmentedControl.selectedColor = [UIColor whiteColor];
        _segmentedControl.color = [UIColor clearColor];
        _segmentedControl.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:SIZE_TEXT_PRIMARY],
                                                   NSForegroundColorAttributeName:COLOR_PRIMARY};
        _segmentedControl.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:SIZE_TEXT_PRIMARY],
                                             NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    return _segmentedControl;
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

-(ASTextNode *)usernameIcon{
    if (!_usernameIcon) {
        _usernameIcon = [[ASTextNode alloc]init];
        _usernameIcon.layerBacked = YES;
        _usernameIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[COLOR_PRIMARY colorWithAlphaComponent:0.5] size:rpx(24) content:ICON_YONG_HU];
        _usernameIcon.size = [_usernameIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.inputArea.layer addSublayer:_usernameIcon.layer];
    }
    return _usernameIcon;
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

-(UIView *)inputLineCenterY{
    if (!_inputLineCenterY) {
        _inputLineCenterY = [[UIView alloc]init];
        _inputLineCenterY.backgroundColor = COLOR_PRIMARY;
        [self.inputArea addSubview:_inputLineCenterY];
    }
    return _inputLineCenterY;
}

-(ASTextNode *)authcodeIcon{
    if (!_authcodeIcon) {
        _authcodeIcon = [[ASTextNode alloc]init];
        _authcodeIcon.layerBacked = YES;
        _authcodeIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[COLOR_PRIMARY colorWithAlphaComponent:0.5] size:rpx(24) content:ICON_YAN_ZHENG_MA];
        _authcodeIcon.size = [_authcodeIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.inputArea.layer addSublayer:_authcodeIcon.layer];
    }
    return _authcodeIcon;
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
        _authcodeButton.y = _authcodeButton.height = INPUT_AREA_HEIGHT / 2.;
        
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
        _submitButton.title = @"登    录";
        _submitButton.cornerRadius = rpx(5);
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(FlatButton *)forgetButton{
    if (!_forgetButton) {
        _forgetButton = [[FlatButton alloc]init];
        _forgetButton.fillColor = [UIColor clearColor];
        _forgetButton.titleSize = SIZE_TEXT_PRIMARY;
        _forgetButton.title = @"忘记密码";
        [_forgetButton addTarget:self action:@selector(clickForgetButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetButton];
    }
    return _forgetButton;
}

-(FlatButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [[FlatButton alloc]init];
        _registerButton.strokeColor = [UIColor whiteColor];
        _registerButton.strokeWidth = LINE_WIDTH;
        _registerButton.fillColor = COLOR_PRIMARY;
        _registerButton.titleSize = SIZE_TEXT_PRIMARY;
        _registerButton.title = @"注    册";
        _registerButton.cornerRadius = rpx(5);
        [_registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerButton];
        
        _registerButton.size = CGSizeMake(rpx(100), rpx(30));
    }
    return _registerButton;
}

-(void)segmentedControlSelected:(NSNumber*)indexValue{
    NSLog(@"选中index:%ld",indexValue.integerValue);
    
    self.authcodeButton.hidden = indexValue.integerValue != 0;
    self.authcodeText.placeholder = indexValue.integerValue == 0 ? @"请输入验证码" : @"请输入密码";
    self.authcodeText.secureTextEntry = indexValue.integerValue != 0;//密码模式
    self.authcodeText.text = @"";//清除掉
    self.authcodeText.keyboardType = indexValue.integerValue == 0 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    
    CGFloat const areaWidth = self.view.width - LEFT_MARGIN * 2;
    self.authcodeText.width = areaWidth - rpx(50) - INPUT_AREA_PADDING - (indexValue.integerValue == 0 ? self.authcodeButton.width : 0);
    
    [self.view endEditing:YES];//结束编辑回收键盘
}

-(void)initNavigationItem{
    //    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    self.titleLabel.text = NAVIGATION_TITLE_LOGIN;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;
    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:SIZE_TEXT_PRIMARY] text:@"关闭" target:self action:@selector(clickClose)];
}

-(void)clickClose{
    [self closeWindow];
}

-(void)closeWindow{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self initInputArea];
    
    [self initSegmentedControl];
    
    [self initButtonArea];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_PRIMARY;
    
    [self initNavigationItem];
}

-(void)initSegmentedControl{
    CGFloat const inputGap = rpx(50);
    CGFloat const segmentedHeight = rpx(40);
    
    self.segmentedControl.frame = CGRectMake(LEFT_MARGIN, self.inputArea.y - inputGap - segmentedHeight, self.view.width - LEFT_MARGIN * 2, segmentedHeight);
}

-(void)initInputArea{
    CGFloat const padding = INPUT_AREA_PADDING;
    
    CGFloat const viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat const iconWidth = rpx(50);
    CGFloat const inputHeight = INPUT_AREA_HEIGHT / 2.;
    CGFloat const areaWidth = viewWidth - LEFT_MARGIN * 2;
    
    self.inputArea.size = CGSizeMake(areaWidth, INPUT_AREA_HEIGHT);
    self.inputArea.x = LEFT_MARGIN;
    self.inputArea.maxY = self.view.height / 2.;
    
    self.usernameIcon.centerX = iconWidth / 2.;
    self.usernameIcon.centerY = inputHeight / 2.;
    
    self.usernameText.frame = CGRectMake(iconWidth, 0, areaWidth - iconWidth - padding, inputHeight);
    
    self.inputLineCenterY.frame = CGRectMake(0, inputHeight, areaWidth, LINE_WIDTH);
    
    self.authcodeIcon.centerX = iconWidth / 2.;
    self.authcodeIcon.centerY = inputHeight + inputHeight / 2.;
    
    self.authcodeButton.maxX = areaWidth;
    
    self.authcodeText.frame = CGRectMake(iconWidth, inputHeight, areaWidth - iconWidth - self.authcodeButton.width - padding, inputHeight);
    
}

-(void)initButtonArea{
    CGFloat const inputGap = rpx(39);
    
    CGFloat const submitHeight = rpx(40);
    
    self.submitButton.frame = CGRectMake(LEFT_MARGIN, self.inputArea.maxY + inputGap, self.view.width - LEFT_MARGIN * 2, submitHeight);
    
    CGFloat const forgetGap = rpx(15);
    self.forgetButton.frame = CGRectMake(LEFT_MARGIN, self.submitButton.maxY + forgetGap, self.view.width - LEFT_MARGIN * 2, submitHeight);
    
    self.registerButton.centerX = self.view.width / 2.;
    self.registerButton.maxY = self.view.height - inputGap;
}

-(void)clickSubmitButton:(UIView*)sender{
    //    [[PopAnimateManager sharedInstance]startClickAnimation:sender];
    
    NSString* phone = self.usernameText.text;
    NSString* authcode = self.authcodeText.text;
    
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    if (self.segmentedControl.currentSelected == 0) {//验证码登录
        if (!authcode || authcode.length != AUTH_CODE_LENGTH) {
            [HudManager showToast:ConcatStrings(@"请输入",@(AUTH_CODE_LENGTH),@"位的验证码!")];
            [PopAnimateManager startShakeAnimation:sender];
            return;
        }
        [SVProgressHUD showWithStatus:@"登陆中..."];// maskType:SVProgressHUDMaskTypeBlack
        __weak __typeof(self) weakSelf = self;
        [self.viewModel loginWithAuthCode:phone authCode:authcode authCodeBean:self->authCodeResult returnBlock:^(id returnValue) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(!strongSelf){//界面已经被销毁
                return;
            }
            [SVProgressHUD dismiss];
            
            [UserDefaultsUtils setObject:phone forKey:PHONE_KEY];//登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
            
            [HudManager showToast:@"登录成功"];
            
            [strongSelf closeWindow];
            
        } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
            [SVProgressHUD dismiss];
            
            [HudManager showToast:errorMsg];
            
            [PopAnimateManager startShakeAnimation:sender];
        }];
    }else{//密码
        if (!authcode || authcode.length < AUTH_CODE_LENGTH) {
            [HudManager showToast:ConcatStrings(@"请输入不少于",@(AUTH_CODE_LENGTH),@"位的密码!")];
            [PopAnimateManager startShakeAnimation:sender];
            return;
        }
        [SVProgressHUD showWithStatus:@"登陆中..."];// maskType:SVProgressHUDMaskTypeBlack
        __weak __typeof(self) weakSelf = self;
        [self.viewModel loginWithPassword:phone password:authcode returnBlock:^(id returnValue) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(!strongSelf){//界面已经被销毁
                return;
            }
            [SVProgressHUD dismiss];
            
            [UserDefaultsUtils setObject:phone forKey:PHONE_KEY];//登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
            
            [HudManager showToast:@"登录成功"];
            
            [strongSelf closeWindow];
            
        } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
            [SVProgressHUD dismiss];
            
            [HudManager showToast:errorMsg];
            
            [PopAnimateManager startShakeAnimation:sender];
        }];
    }
}

-(void)clickForgetButton:(UIView*)sender{//跳转忘记密码界面
    PasswordViewController* passwordViewController = [[PasswordViewController alloc]init];
    [self.navigationController pushViewController:passwordViewController animated:YES];
}

-(void)clickRegisterButton:(UIView*)sender{//跳转注册界面
    RegisterViewController* registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
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
    [self.viewModel getAuthCode:phone type:AuthCodeTypeNormal returnBlock:^(AuthCodeModel* authCodeModel) {
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
    
    self.authcodeButton.title = ConcatStrings(@"",@(MAX_TIMER_COUNT_DOWN),@"s后重发");;
    
//    self->countDownSecond = MAX_COUNT_DOWN;
//    self.authcodeButton.title = [[NSNumber numberWithInteger:countDownSecond] stringValue];
//    
//    [self timerCancel];
//    
//    self->timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
//    [[NSRunLoop currentRunLoop]addTimer:self->timer forMode:NSRunLoopCommonModes];
}

//-(void)timerCancel{
//    if (timer) {
//        [timer invalidate];//取消原来的计时器
//        timer = nil;
//    }
//}
//
//-(void)countDownAction{
//    countDownSecond --;
//    self.authcodeButton.title = [[NSNumber numberWithInteger:countDownSecond] stringValue];
//    if (countDownSecond <= 0) {
//        [self endCountDown];
//    }
//}

-(void)endCountDown{
//    [self timerCancel];
    self.authcodeButton.title = @"发送验证码";
    self.authcodeButton.titleColor = COLOR_PRIMARY;//恢复颜色
    self.authcodeButton.userInteractionEnabled = YES;//恢复交互
}


//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
