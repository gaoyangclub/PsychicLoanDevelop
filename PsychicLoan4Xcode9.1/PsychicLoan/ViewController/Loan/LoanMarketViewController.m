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
#import "DetailViewController.h"
#import "HudManager.h"
#import "MobClickEventManager.h"
#import "DiyRotateRefreshHeader.h"

@interface LoanMarketViewController()<LoanMarketFilterDelegate>

@property(nonatomic,retain)LoanMarketFilterView* filterView;
@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)LoanViewModel* viewModel;

@property(nonatomic,retain)ASDisplayNode* noticeBack;
@property(nonatomic,retain)ASTextNode* noticeLabel;
@property(nonatomic,retain)ASTextNode* noticeIcon;

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

-(MJRefreshHeader *)getHeader{
    return [[DiyRotateRefreshHeader alloc]init];
}

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

-(ASDisplayNode *)noticeBack{
    if (!_noticeBack) {
        _noticeBack = [[ASDisplayNode alloc]init];
        _noticeBack.backgroundColor = COLOR_NOTICE_BACK;
        _noticeBack.layerBacked = YES;
        [self.view.layer addSublayer:_noticeBack.layer];
    }
    return _noticeBack;
}

-(ASTextNode *)noticeIcon{
    if (!_noticeIcon) {
        _noticeIcon = [[ASTextNode alloc]init];
        _noticeIcon.layerBacked = YES;
        _noticeIcon.attributedText = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor whiteColor] size:rpx(16) content:ICON_GONG_GAO];
        [_noticeIcon sizeToFit];
        [self.noticeBack addSubnode:_noticeIcon];
    }
    return _noticeIcon;
}

-(ASTextNode *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[ASTextNode alloc]init];
        _noticeLabel.layerBacked = YES;
        _noticeLabel.attributedText = [NSString simpleAttributedString:[UIColor whiteColor] size:SIZE_TEXT_SECONDARY content:LOAN_MARKET_PAGE_NOTICE_TEXT];
        [_noticeLabel sizeToFit];
        [self.noticeBack addSubnode:_noticeLabel];
    }
    return _noticeLabel;
}

-(CGRect)getTableViewFrame{
    self.noticeBack.frame = CGRectMake(0, self.filterView.maxY, self.view.width, NOTICE_BACK_HEIGHT);
    
    return CGRectMake(0, self.noticeBack.maxY, self.view.width, self.view.height - self.noticeBack.maxY);
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
    
    CGFloat const leftMargin = rpx(10);
    self.noticeLabel.centerY = self.noticeIcon.centerY = NOTICE_BACK_HEIGHT / 2.;
    self.noticeIcon.x = leftMargin;
    self.noticeLabel.x = self.noticeIcon.maxX + leftMargin;
    
    [MobClickEventManager loanMarketControllerDidLoad];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoansByFilter:self.filterView.mintime maxtime:self.filterView.maxtime search:self.filterView.search minamount:self.filterView.minamount maxamount:self.filterView.maxamount returnBlock:^(NSArray<LoanModel*>* loanModels) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [strongSelf.tableView clearSource];
        SourceVo* svo = svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:nil];
        for (LoanModel* loanModel in loanModels) {
            CellVo* cvo = [CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel];
            cvo.cellName = MOBCLICK_EVENT_MARKET;
            [svo.data addObject:cvo];
        }
        [strongSelf.tableView addSource:svo];
        
        handler(YES);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [HudManager showToast:errorMsg];
        //        self.emptyDataSource.netError = YES;
        //        [self.tableView clearSource];
        handler(NO);
    }];
}

-(void)loanFilterSelected:(LoanMarketFilterView *)view{
    [self.tableView headerBeginRefresh];//继续刷新
    
    [MobClickEventManager loanMarketFilterSelected:[NSString stringWithFormat:@"%d-%d",view.minamount,view.maxamount] search:[NSString stringWithFormat:@"%d",view.search] time:[NSString stringWithFormat:@"%d-%d",view.mintime,view.maxtime]];
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [self.tableView getCellVoByIndexPath:indexPath];
    DetailViewController* viewController = [[DetailViewController alloc]init];
    long loanId = ((LoanModel*)cvo.cellData).loanid;
    viewController.loanId = loanId;
    viewController.loanName = ((LoanModel*)cvo.cellData).loanname;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    [MobClickEventManager loanTypeClickByEvent:cvo.cellName loanid:loanId isLink:NO];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
