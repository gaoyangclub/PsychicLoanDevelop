//
//  CustomerServiceController.m
//  PsychicLoan
//
//  Created by 高扬 on 17/12/2.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "CustomerServiceController.h"
#import "CustomerServiceCell.h"
#import "MobClickEventManager.h"

@interface CustomerServiceController()

@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)CustomerServiceCell* customerServiceCell;

@end

@implementation CustomerServiceController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(CustomerServiceCell *)customerServiceCell{
    if (!_customerServiceCell) {
        _customerServiceCell = [[CustomerServiceCell alloc]init];
        _customerServiceCell.cellVo = [CellVo initWithParams:CELL_AUTO_HEIGHT cellClass:CustomerServiceCell.class cellData:MOBCLICK_EVENT_USER_CUSTOMER];
        [self.view addSubview:_customerServiceCell];
    }
    return _customerServiceCell;
}

-(void)initNavigationItem{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = NAVIGATION_TITLE_CUSTOMER_SERVICE;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    [self.navigationController.navigationBar jk_setNavigationBarBackgroundColor:COLOR_PRIMARY];
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    self.customerServiceCell.frame = CGRectMake(0, rpx(5), self.view.width, CUSTOM_SERVICE_HEIGHT);
    [self.customerServiceCell showSubviews];
}



@end
