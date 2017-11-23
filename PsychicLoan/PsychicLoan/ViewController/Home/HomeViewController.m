//
//  HomeViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerCell.h"
#import "HomeFastCell.h"
#import "HomeLoanTitleSection.h"
#import "LoanModel.h"
#import "LoanNormalCell.h"
#import "HomeMoreTipsCell.h"
#import "LoanTypeViewController.h"
#import "HomeViewModel.h"
#import "HomeModel.h"
#import "DetailViewController.h"

//@interface TestTableViewCell : MJTableViewCell
//
//@end
//@implementation TestTableViewCell
//
//-(void)showSubviews{
////    self.backgroundColor = [UIColor whiteColor];
//    self.textLabel.text = (NSString*)self.data;
//}
//
//@end

@interface HomeViewController ()

@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)HomeViewModel* viewModel;

@end

@implementation HomeViewController

-(BOOL)getShowFooter{
    return NO;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_HOME superView:nil];
    }
    return _titleLabel;
}

-(HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc]init];
    }
    return _viewModel;
}

//-(CGRect)getTableViewFrame{
//    return CGRectMake(0, 0, self.view.width, self.view.height - 10);
//}

-(void)initNavigationItem{
//    self.navigationItem.leftBarButtonItem =
//    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    //    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    self.titleLabel.text = NAVIGATION_TITLE_HOME;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
//    if (!self.hidesBottomBarWhenPushed) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getHomeLoans:^(HomeModel* homeModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView clearSource];
        
        SourceVo* svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_BANNER_CELL_HEIGHT cellClass:[HomeBannerCell class] cellData:homeModel.banner cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_FAST_CELL_HEIGHT cellClass:[HomeFastCell class] cellData:NULL cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:HOME_LOCATION_SECTION_HEIGHT headerClass:[HomeLoanTitleSection class] headerData:@(LOAN_TYPE_HOT)];
//        NSMutableArray<LoanModel*>* loanModels = [self generateTempLoanModels];
        for (LoanModel* loanModel in homeModel.hotloan) {
            [svo.data addObject:[CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel]];
        }
        [strongSelf.tableView addSource:svo];
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:HOME_LOCATION_SECTION_HEIGHT headerClass:[HomeLoanTitleSection class] headerData:@(LOAN_TYPE_RECOMMEND)];
//        loanModels = [self generateTempLoanModels];
        for (LoanModel* loanModel in homeModel.recommend) {
            [svo.data addObject:[CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel]];
        }
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_MORE_TIPS_CELL_HEIGHT cellClass:[HomeMoreTipsCell class] cellData:NULL cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        handler(YES);
        
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        
    }];
}


-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [self.tableView getCellVoByIndexPath:indexPath];
    if ([cvo.cellData isKindOfClass:[LoanModel class]]) {
        DetailViewController* viewController = [[DetailViewController alloc]init];
        viewController.loanId = ((LoanModel*)cvo.cellData).loanid;
        viewController.loanName = ((LoanModel*)cvo.cellData).loanname;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

//-(NSMutableArray<LoanModel*>*)generateTempLoanModels{
//    NSInteger count = (arc4random() % 5) + 3;
//    NSMutableArray<LoanModel*>* loanModels = [NSMutableArray<LoanModel*> array];
//    for (NSInteger i = 0; i < count; i++) {
//        LoanModel* loanModel = [[LoanModel alloc]init];
//        loanModel.loanname = @"牛逼贷";
//        loanModel.loandes = @"绝对牛逼的贷款";
//        loanModel.maxamount = 10000;
//        loanModel.loanlogo = @"http://3.pic.paopaoche.net/up/2015-7/201579103655.png";
//        loanModel.loanurl = @"https://www.baidu.com";
//        [loanModels addObject:loanModel];
//    }
//    
//    return loanModels;
//}

//-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
//    double delayInSeconds = 1.0;
//    __weak __typeof(self) weakSelf = self;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        SourceVo* svo = [self.tableView getLastSource];
//        NSInteger startIndex = svo.data.count;
//        for (NSInteger i = 0; i < 10; i ++) {
//            [svo.data addObject:[CellVo initWithParams:50 cellClass:[TestTableViewCell class] cellData:ConcatStrings(@"数据",@(startIndex + i + 1))]];
//        }
//        handler(YES);
//    });
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.tableView.cellGap = rpx(10);
    
    [self initNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
