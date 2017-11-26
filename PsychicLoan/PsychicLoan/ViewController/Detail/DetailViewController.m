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

@interface DetailViewController ()

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
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = rpx(16);
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

-(BOOL)getShowFooter{
    return NO;
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = self.loanName;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

-(void)clickSubmitButton:(UIView*)sender{
    
}

-(CGRect)getTableViewFrame{
    CGFloat const BUTTON_AREA_HEIGHT = rpx(35);
    CGFloat const margin = 0;//rpx(4);
    
    CGFloat const viewWidth = self.view.width;
    CGFloat const viewHeight = self.view.height;
    CGFloat const viewGap = rpx(5);
    
    self.submitButton.frame = CGRectMake(margin, viewHeight - BUTTON_AREA_HEIGHT + margin, viewWidth - margin * 2, BUTTON_AREA_HEIGHT - margin * 2);
    
    return CGRectMake(margin, 0, viewWidth - margin * 2, viewHeight - BUTTON_AREA_HEIGHT - viewGap);
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoanDetailById:self.loanId returnBlock:^(LoanDetailModel* loanDetailModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView clearSource];
        
        SourceVo* svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:nil];
        [svo.data addObject:[CellVo initWithParams:DETAIL_LOGO_CELL_HEIGHT cellClass:[DetailLogoCell class] cellData:loanDetailModel cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:LOAN_SECTION_HEIGHT headerClass:[LoanTitleSection class] headerData:@"基本信息"];
        [svo.data addObject:[CellVo initWithParams:DETAIL_BASIC_CELL_HEIGHT cellClass:[DetailBasicCell class] cellData:loanDetailModel cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:LOAN_SECTION_HEIGHT headerClass:[LoanTitleSection class] headerData:@"申请资料"];
        [svo.data addObject:[CellVo initWithParams:1 cellClass:[DetailMaterialCell class] cellData:loanDetailModel cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:LOAN_SECTION_HEIGHT headerClass:[LoanTitleSection class] headerData:@"客服信息"];
        [svo.data addObject:[CellVo initWithParams:CUSTOM_SERVICE_HEIGHT cellClass:[CustomerServiceCell class] cellData:nil cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        handler(YES);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.tableView.sectionGap = rpx(5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
