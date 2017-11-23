//
//  LoanMarketViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanMarketViewController.h"
#import "LoanMarketFilterView.h"

@interface LoanMarketViewController ()

@property(nonatomic,retain)LoanMarketFilterView* filterView;
@property(nonatomic,retain)UILabel* titleLabel;

@end

@implementation LoanMarketViewController

-(BOOL)getShowFooter{
    return NO;
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
    self.navigationController.navigationBar.jk_barBackgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
