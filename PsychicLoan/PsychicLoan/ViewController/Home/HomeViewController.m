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
#import "LoanModel.h"
#import "LoanNormalCell.h"
#import "HomeMoreTipsCell.h"
#import "LoanTypeViewController.h"
#import "HomeViewModel.h"
#import "HomeModel.h"
#import "DetailViewController.h"
#import "LoanTitleSection.h"
#import "UserDefaultsUtils.h"
#import "HomePopModelView.h"
#import "BannerModel.h"
#import "HudManager.h"
#import "AppViewManager.h"
#import "MobClickEventManager.h"
#import "PushModel.h"
#import "HSUpdateApp.h"
#import "OpenUrlUtils.h"
#import "DiyRotateRefreshHeader.h"

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

@interface HomeViewController (){
    BOOL isPopView;
}

@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)HomeViewModel* viewModel;
@property(nonatomic,retain)HomePopModelView* homePopView;

@end

@implementation HomeViewController

-(BOOL)getShowFooter{
    return NO;
}

-(MJRefreshHeader *)getHeader{
    return [[DiyRotateRefreshHeader alloc]init];
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

-(HomePopModelView *)homePopView{
    if (!_homePopView) {
        _homePopView = [[HomePopModelView alloc]init];
    }
    return _homePopView;
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
    self.navigationController.navigationBar.jk_barBackgroundColor = COLOR_PRIMARY;//[UIColor whiteColor];
//    if (!self.hidesBottomBarWhenPushed) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getHomeLoans:^(HomeModel* homeModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [strongSelf.tableView clearSource];
        
        SourceVo* svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_BANNER_CELL_HEIGHT cellClass:[HomeBannerCell class] cellData:homeModel.banner cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_FAST_CELL_HEIGHT cellClass:[HomeFastCell class] cellData:homeModel.btntext cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:LOAN_SECTION_HEIGHT headerClass:[LoanTitleSection class] headerData:[Config getLoanTypeNameByCode:LOAN_TYPE_HOT]];
//        NSMutableArray<LoanModel*>* loanModels = [self generateTempLoanModels];
        for (LoanModel* loanModel in homeModel.hotloan) {
            CellVo* cvo = [CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel];
            cvo.cellName = MOBCLICK_EVENT_HOT;
            [svo.data addObject:cvo];
        }
        [strongSelf.tableView addSource:svo];
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:LOAN_SECTION_HEIGHT headerClass:[LoanTitleSection class] headerData:[Config getLoanTypeNameByCode:LOAN_TYPE_RECOMMEND]];
//        loanModels = [self generateTempLoanModels];
        for (LoanModel* loanModel in homeModel.recommend) {
            CellVo* cvo = [CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel];
            cvo.cellName = MOBCLICK_EVENT_RECOMMEND;
            [svo.data addObject:cvo];
        }
        [strongSelf.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_MORE_TIPS_CELL_HEIGHT cellClass:[HomeMoreTipsCell class] cellData:NULL cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [strongSelf.tableView addSource:svo];
        
        if (homeModel.wechat) {
            [Config setOfficialAccounts:homeModel.wechat.official_accounts];
            [Config setWechat:homeModel.wechat.wechat];
        }
        
        handler(YES);
        
        if (!strongSelf->isPopView) {
            strongSelf->isPopView = YES;
            NSTimeInterval period = 1; //设置时间间隔
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, period * NSEC_PER_SEC);
            dispatch_after(popTime, queue, ^(void){
                [strongSelf getHomePopInfo];
                [strongSelf checkVersion];
            });
        }
        
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        
        [HudManager showToast:errorMsg];
//        self.emptyDataSource.netError = YES;
//        [self.tableView clearSource];
        handler(NO);
    }];
}


-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [self.tableView getCellVoByIndexPath:indexPath];
    if ([cvo.cellData isKindOfClass:[LoanModel class]]) {
        DetailViewController* viewController = [[DetailViewController alloc]init];
        long loanId = ((LoanModel*)cvo.cellData).loanid;
        viewController.loanId = loanId;
        viewController.loanName = ((LoanModel*)cvo.cellData).loanname;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
        [MobClickEventManager loanTypeClickByEvent:cvo.cellName loanid:loanId isLink:NO];
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

-(BOOL)autoRefreshHeader{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.tableView.sectionGap = rpx(5);
    
    [self initNavigationItem];
    
    [self checkLoginItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkLoginItem)
                                                 name:EVENT_LOGOUT
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkLoginItem)
                                                 name:EVENT_LOGIN_COMPLETE
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshHome)
                                                 name:EVENT_REFRESH_HOME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventShowHomePop:)
                                                 name:EVENT_SHOW_HOME_POP
                                               object:nil];
    
    
    
    [MobClickEventManager homeViewControllerDidLoad];
}

-(void)refreshHome{
    [self.tableView headerBeginRefresh];
}

-(void)checkVersion{
    //@"1324404459"
    [HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        if (isUpdate) {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"" message:ConcatStrings(APPLICATION_NAME,@"检测到新版本，是否立即下载?") preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [OpenUrlUtils openUrlByString:openUrl];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [[AppViewManager getRootTabBarController] presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

-(void)getHomePopInfo{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getHomePopView:^(BannerModel* bannerModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [strongSelf showHomePopView:bannerModel];
        
    } failureBlock:nil];
}

-(void)showHomePopView:(BannerModel*)bannerModel{
    self.homePopView.bannerModel = bannerModel;
    [self.homePopView show];
    [MobClickEventManager homePopWillShow];
    [self showSystemBadge:0];//清空SystemBadge
}

-(void)showSystemBadge:(NSInteger)count{
//    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [appDelegate.rootTabBarController setItemBadge:count atIndex:0];
    [UIApplication sharedApplication].applicationIconBadgeNumber = count;
}

-(void)eventShowHomePop:(NSNotification*)eventData{
    if(self->isPopView){//已经显示过了 再显示
        PushModel* pushModel = eventData.object;
        [self showHomePopView:pushModel];
    }
}

-(void)checkLoginItem{
    if (![UserDefaultsUtils getObject:PHONE_KEY]) {
        self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:SIZE_TEXT_PRIMARY] text:@"登录" target:self action:@selector(clickLogin)];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)clickLogin{
    [AppViewManager popLoginViewController];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGIN_COMPLETE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_REFRESH_HOME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_SHOW_HOME_POP object:nil];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
