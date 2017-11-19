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

@interface LoanTypeViewController()

@property(nonatomic,retain)FlatButton* noticeArea;

@end

@implementation LoanTypeViewController

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
    
    return CGRectMake(0, noticeHeight, self.view.width, self.view.height);
}

-(BOOL)getShowFooter{
    return NO;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    double delayInSeconds = 1.0;
    __weak __typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView clearSource];
        SourceVo* svo = svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:nil];
        NSMutableArray<LoanModel*>* loanModels = [self generateTempLoanModels];
        for (LoanModel* loanModel in loanModels) {
            [svo.data addObject:[CellVo initWithParams:HOME_LOAN_NORMAL_CELL_HEIGHT cellClass:[LoanNormalCell class] cellData:loanModel]];
        }
        [self.tableView addSource:svo];
        
        handler(YES);
    });
}


-(NSMutableArray<LoanModel*>*)generateTempLoanModels{
    NSInteger count = (arc4random() % 5) + 32;
    
    NSMutableArray<LoanModel*>* loanModels = [NSMutableArray<LoanModel*> array];
    for (NSInteger i = 0; i < count; i++) {
        LoanModel* loanModel = [[LoanModel alloc]init];
        loanModel.loanname = @"牛逼贷";
        loanModel.loandes = @"绝对牛逼的贷款";
        loanModel.maxamount = @"￥10000";
        loanModel.loanlogo = @"http://3.pic.paopaoche.net/up/2015-7/201579103655.png";
        loanModel.loanurl = @"https://www.baidu.com";
        [loanModels addObject:loanModel];
    }
    
    return loanModels;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat const gap = rpx(10);
    
    self.tableView.cellGap = gap;
//    self.tableView.contentInset = UIEdgeInsetsMake(gap, 0, -gap, 0);
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
