//
//  LoanMarketViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanMarketViewController.h"
#import "LoanMarketFilterView.h"
#import "LoanViewModel.h"
#import "LoanModel.h"
#import "LoanNormalCell.h"

@interface LoanMarketViewController()<LoanMarketFilterDelegate>

@property(nonatomic,retain)LoanMarketFilterView* filterView;
@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)LoanViewModel* viewModel;

@end

@implementation LoanMarketViewController

-(LoanViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoanViewModel alloc]init];
    }
    return _viewModel;
}

-(BOOL)getShowFooter{
    return NO;
}

//-(BOOL)getShowHeader{
//    return NO;
//}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_LOAN superView:nil];
    }
    return _titleLabel;
}

-(LoanMarketFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[LoanMarketFilterView alloc]initWithOrigin:CGPointMake(0, 0) andHeight:rpx(45)];
        _filterView.filterDelegate = self;
        [self.view addSubview:_filterView];
    }
    return _filterView;
}

-(CGRect)getTableViewFrame{
//    self.filterView.width = self.view.width;
    return CGRectMake(0, self.filterView.height, self.view.width, self.view.height - self.filterView.height);
}

-(void)initNavigationItem{
    self.titleLabel.text = NAVIGATION_TITLE_LOAN;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;//[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoansByFilter:self.filterView.mintime maxtime:self.filterView.maxtime search:self.filterView.search minamount:self.filterView.minamount maxamount:self.filterView.maxamount returnBlock:^(NSArray<LoanModel*>* loanModels) {
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

-(void)loanFilterSelected:(LoanMarketFilterView *)view{
    [self.tableView headerBeginRefresh];//继续刷新
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
