//
//  DetailViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "DetailViewController.h"
#import "FlatButton.h"
#import "DetailViewModel.h"
#import "LoanDetailModel.h"
#import "DetailBasicCell.h"
#import "DetailLogoCell.h"
#import "DetailMaterialCell.h"
#import "CustomerServiceCell.h"
#import "LoanTitleSection.h"
#import "HudManager.h"
#import "UserDefaultsUtils.h"
#import "WebViewController.h"
#import "AppViewManager.h"

#import "UMMobClick/MobClick.h"
#import "MobClickEventManager.h"
#import "DiyRotateRefreshHeader.h"

@interface DetailViewController (){
    LoanDetailModel* loanDetailResult;
}

@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)FlatButton* submitButton;
@property(nonatomic,retain)DetailViewModel* viewModel;

@end

@implementation DetailViewController


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(DetailViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[DetailViewModel alloc]init];
    }
    return _viewModel;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
//        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = SIZE_TEXT_LARGE;
        _submitButton.title = @"申请贷款";
        _submitButton.cornerRadius = 0;
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(MJRefreshHeader *)getRefreshHeader{
    return [[DiyRotateRefreshHeader alloc]init];
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = self.loanName;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    [self.navigationController.navigationBar jk_setNavigationBarBackgroundColor:COLOR_PRIMARY];
}

-(void)clickSubmitButton:(UIView*)sender{
    if (self->loanDetailResult) {
        [AppViewManager popLoginNextWebController:self->loanDetailResult navigationController:self.navigationController];
        [MobClickEventManager detailSubmitClick:self.loanId];
    }
//    if (![UserDefaultsUtils getObject:PHONE_KEY]) {//重新登录
//        [AppViewManager popLoginViewController];
//        __weak __typeof(self) weakSelf = self;
//        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:EVENT_LOGIN_COMPLETE object:nil] subscribeNext:^(id x) {
//            [weakSelf gotoWebViewController:NO];
//        }];
//    }else{
//        [self gotoWebViewController:YES];
////        [MobClick event:@"Forward"];
//    }
}

//-(void)gotoWebViewController:(BOOL)animated{
//    if (self->loanDetailResult) {
//        WebViewController* viewController = [[WebViewController alloc]init];
//        viewController.loanId = self->loanDetailResult.loanid;
//        viewController.navigationTitle = self.loanName;
//        viewController.linkUrl = self->loanDetailResult.loanurl;
//        viewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:viewController animated:animated];
//    }
//}

-(CGRect)getTableViewFrame{
    CGFloat const BUTTON_AREA_HEIGHT = rpx(50);
    
    CGFloat const viewWidth = self.view.width;
    CGFloat const viewHeight = self.view.height;
    CGFloat const viewGap = rpx(5);
    
    self.submitButton.frame = CGRectMake(0, viewHeight - BUTTON_AREA_HEIGHT, viewWidth, BUTTON_AREA_HEIGHT);
    
    return CGRectMake(0, viewGap, viewWidth, viewHeight - BUTTON_AREA_HEIGHT - viewGap * 2);
}

-(void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoanDetailById:self.loanId returnBlock:^(LoanDetailModel* loanDetailModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面销毁了
            return;
        }
        strongSelf->loanDetailResult = loanDetailModel;
        
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:DETAIL_LOGO_CELL_HEIGHT cellClass:DetailLogoCell.class cellData:loanDetailModel isUnique:YES]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:LOAN_SECTION_HEIGHT sectionHeaderClass:LoanTitleSection.class sectionHeaderData:@"基本信息" nextBlock:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:DETAIL_BASIC_CELL_HEIGHT cellClass:DetailBasicCell.class cellData:loanDetailModel isUnique:YES]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:LOAN_SECTION_HEIGHT sectionHeaderClass:LoanTitleSection.class sectionHeaderData:@"申请资料" nextBlock:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:CELL_AUTO_HEIGHT cellClass:DetailMaterialCell.class cellData:loanDetailModel isUnique:YES]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:LOAN_SECTION_HEIGHT sectionHeaderClass:LoanTitleSection.class sectionHeaderData:@"客服信息" nextBlock:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:CUSTOM_SERVICE_HEIGHT cellClass:CustomerServiceCell.class cellData:MOBCLICK_EVENT_DETAIL_CUSTOMER isUnique:YES]];
        }]];
        
        endRefreshHandler(YES);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [HudManager showToast:errorMsg];
//        self.emptyDataSource.netError = YES;
//        [self.tableView clearSource];
        endRefreshHandler(NO);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.tableView.sectionGap = rpx(5);
    
    [MobClickEventManager detailViewControllerDidLoad:self.loanId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
