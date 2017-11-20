//
//  LoanTypeViewController.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/19.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanTypeViewController.h"
#import "FlatButton.h"
#import "LoanModel.h"
#import "LoanNormalCell.h"
#import "AppDelegate.h"
#import "LoanViewModel.h"

@interface LoanTypeViewController()

@property(nonatomic,retain)FlatButton* noticeArea;
@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)LoanViewModel* viewModel;

@end

@implementation LoanTypeViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(LoanViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoanViewModel alloc]init];
    }
    return _viewModel;
}

-(FlatButton *)noticeArea{
    if (!_noticeArea) {
        _noticeArea = [[FlatButton alloc]init];
        _noticeArea.titleSize = SIZE_TEXT_SECONDARY;
        _noticeArea.titleColor = COLOR_TEXT_PRIMARY;
        _noticeArea.title = @"公告:审核防水，要借速度";
        _noticeArea.fillColor = [FlatSkyBlue colorWithAlphaComponent:0.3];
        _noticeArea.cornerRadius = 0;
        [self.view addSubview:_noticeArea];
    }
    return _noticeArea;
}

-(CGRect)getTableViewFrame{
    CGFloat const noticeHeight = rpx(30);
    self.noticeArea.frame = CGRectMake(0, 0, self.view.width, noticeHeight);
    
    return CGRectMake(0, noticeHeight, self.view.width, self.view.height - noticeHeight);
}

-(BOOL)getShowFooter{
    return NO;
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = [Config getLoanTypeNameByCode:self.loanType];//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    //    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"下一个"
//                                              style:UIBarButtonItemStylePlain
//                                              target:self
//                                              action:@selector(openNextController:)];
}

//-(void)openNextController:(UIView*)sender{//测试点击下一个
//    LoanTypeViewController* vc = [[LoanTypeViewController alloc]init];
//    vc.loanType = self.loanType;
//    vc.hidesBottomBarWhenPushed = YES;
//    //    [self.navigationController pushViewController:vc animated:YES];
//    [[AppDelegate getCurrentNavigationController] pushViewController:vc animated:YES];
//}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
//    double delayInSeconds = 1.0;
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoansByType:self.loanType returnBlock:^(NSArray<LoanModel*>* loanModels) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView clearSource];
        SourceVo* svo = svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:nil];
        for (LoanModel* loanModel in loanModels) {
            [svo.data addObject:[CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel]];
        }
        [strongSelf.tableView addSource:svo];
        
        handler(YES);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        
    }];
}


//-(NSMutableArray<LoanModel*>*)generateTempLoanModels{
//    NSInteger count = (arc4random() % 5) + 32;
//    
//    NSMutableArray<LoanModel*>* loanModels = [NSMutableArray<LoanModel*> array];
//    for (NSInteger i = 0; i < count; i++) {
//        LoanModel* loanModel = [[LoanModel alloc]init];
//        loanModel.loanname = @"牛逼贷";
//        loanModel.loandes = @"绝对牛逼的贷款";
//        loanModel.maxamount = @"￥10000";
//        loanModel.loanlogo = @"http://3.pic.paopaoche.net/up/2015-7/201579103655.png";
//        loanModel.loanurl = @"https://www.baidu.com";
//        [loanModels addObject:loanModel];
//    }
//    
//    return loanModels;
//}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNavigationItem];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    CGFloat const gap = rpx(10);
    
    self.tableView.cellGap = gap;
    self.tableView.contentInset = UIEdgeInsetsMake(gap, 0, gap, 0);
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
