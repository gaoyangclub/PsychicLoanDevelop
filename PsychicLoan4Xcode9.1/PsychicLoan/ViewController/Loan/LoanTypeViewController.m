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
#import "DetailViewController.h"
#import "HudManager.h"
#import "MobClickEventManager.h"
#import "DiyRotateRefreshHeader.h"

@interface LoanTypeViewController()

//@property(nonatomic,retain)FlatButton* noticeArea;
@property(nonatomic,retain)ASDisplayNode* noticeBack;
@property(nonatomic,retain)ASTextNode* noticeLabel;
@property(nonatomic,retain)ASTextNode* noticeIcon;
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
        _noticeLabel.attributedText = [NSString simpleAttributedString:[UIColor whiteColor] size:SIZE_TEXT_SECONDARY content:LOAN_TYPE_PAGE_NOTICE_TEXT];
        [_noticeLabel sizeToFit];
        [self.noticeBack addSubnode:_noticeLabel];
    }
    return _noticeLabel;
}

//-(FlatButton *)noticeArea{
//    if (!_noticeArea) {
//        _noticeArea = [[FlatButton alloc]init];
//        _noticeArea.titleSize = SIZE_TEXT_SECONDARY;
//        _noticeArea.titleColor = COLOR_TEXT_PRIMARY;
//        _noticeArea.title = @"公告:审核防水，要借速度";
//        _noticeArea.fillColor = [FlatSkyBlue colorWithAlphaComponent:0.3];
//        _noticeArea.cornerRadius = 0;
//        [self.view addSubview:_noticeArea];
//    }
//    return _noticeArea;
//}

-(CGRect)getTableViewFrame{
//    CGFloat const noticeHeight = rpx(30);
    self.noticeBack.frame = CGRectMake(0, 0, self.view.width, NOTICE_BACK_HEIGHT);
    
    return CGRectMake(0, NOTICE_BACK_HEIGHT, self.view.width, self.view.height - NOTICE_BACK_HEIGHT);
}

-(MJRefreshHeader *)getRefreshHeader{
    return [[DiyRotateRefreshHeader alloc]init];
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = self.navigationTitle ? self.navigationTitle : @"";//[Config getLoanTypeNameByCode:self.loanType];//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    //    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar jk_setNavigationBarBackgroundColor:COLOR_PRIMARY];
    
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

-(void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    double delayInSeconds = 1.0;
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getLoansByType:self.loanType returnBlock:^(NSArray<LoanModel*>* loanModels) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面销毁了
            return;
        }
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:LoanNormalCell.class sourceArray:loanModels]];
            //cvo.cellName = MOBCLICK_EVENT_FAST;
        }]];
        
        endRefreshHandler(YES);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [HudManager showToast:errorMsg];
        //        self.emptyDataSource.netError = YES;
        //        [self.tableView clearSource];
        endRefreshHandler(NO);
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
    
//    CGFloat const gap = rpx(10);
//    self.tableView.cellGap = gap;
//    self.tableView.contentInset = UIEdgeInsetsMake(gap, 0, gap, 0);
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat const leftMargin = rpx(10);
    self.noticeLabel.centerY = self.noticeIcon.centerY = NOTICE_BACK_HEIGHT / 2.;
    self.noticeIcon.x = leftMargin;
    self.noticeLabel.x = self.noticeIcon.maxX + leftMargin;
}
-(void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellVo* cvo = [tableView getCellVoByIndexPath:indexPath];
    DetailViewController* viewController = [[DetailViewController alloc]init];
    long loanId = ((LoanModel*)cvo.cellData).loanid;
    viewController.loanId = loanId;
    viewController.loanName = ((LoanModel*)cvo.cellData).loanname;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    [MobClickEventManager loanTypeClickByEvent:cvo.cellName loanid:loanId isLink:NO];
}

@end
