//
//  HomeViewController.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerCell.h"

@interface TestTableViewCell : MJTableViewCell

@end
@implementation TestTableViewCell

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface HomeViewController ()

@property(nonatomic,retain)UILabel* titleLabel;

@end

@implementation HomeViewController

-(BOOL)getShowFooter{
    return NO;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_HOME superView:nil];
    }
    return _titleLabel;
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
    double delayInSeconds = 1.0;
    __weak __typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView clearSource];
        
        NSInteger hi = (arc4random() % 2); //生成0-1范围的随机数
        NSArray<NSString*>* imageArr;
        if (hi > 0) {
            imageArr = @[
                         @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=cfb53f93c3177f3e0439f44e18a651b2/6609c93d70cf3bc7814060c9db00baa1cd112a56.jpg",
                         @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=c55331232c9759ee5e5d6888da922963/3c6d55fbb2fb4316a08b2f542aa4462309f7d30c.jpg",
                         @"http://pic.58pic.com/58pic/13/71/22/35T58PICrEk_1024.jpg"];
        }else{
            imageArr = @[
                         @"http://img.juimg.com/tuku/yulantu/140313/330457-14031320362254.jpg",
                         @"http://img.taopic.com/uploads/allimg/130331/240460-13033106243430.jpg"
                         ];
        }
        
        SourceVo* svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        [svo.data addObject:[CellVo initWithParams:HOME_BANNER_CELL_HEIGHT cellClass:[HomeBannerCell class] cellData:imageArr cellTag:CELL_TAG_NORMAL isUnique:YES]];
        [self.tableView addSource:svo];
        
        svo = [SourceVo initWithParams:[NSMutableArray<CellVo*> array] headerHeight:0 headerClass:nil headerData:NULL];
        for (NSInteger i = 0; i < 20; i ++) {
            [svo.data addObject:[CellVo initWithParams:50 cellClass:[TestTableViewCell class] cellData:ConcatStrings(@"数据",@(i + 1))]];
        }
        [self.tableView addSource:svo];
        handler(YES);
    });
}

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
    
    [self initNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
