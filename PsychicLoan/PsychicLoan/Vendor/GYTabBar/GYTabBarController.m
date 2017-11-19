//
//  GYTabBarController.m
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "GYTabBarController.h"

@interface GYTabBarController ()<GYTabBarDelegate>{
    BOOL changeData;
}

@property(nonatomic,retain) GYTabBarView* tabBarView;
@property(nonatomic,retain) UIView* lineView;

@end

@implementation GYTabBarController

//-(CGFloat)tabBarHeight{
//    if(!_tabBarHeight){
//        _tabBarHeight = 50;//默认
//    }
//    return _tabBarHeight;
//}

-(void)setItemClass:(Class)itemClass{
    _itemClass = itemClass;
    changeData = YES;
    [self.view setNeedsLayout];
}

-(void)setDataArray:(NSArray<TabData *> *)dataArray{
    _dataArray = dataArray;
    changeData = YES;
    [self.view setNeedsLayout];
}

-(void)setItemBadge:(NSInteger)badge atIndex:(NSInteger)index {
    if (index < _dataArray.count) {
        _dataArray[index].badge = badge;
    }
}

-(GYTabBarView *)tabBarView{
    if (!_tabBarView) {
        _tabBarView = [[GYTabBarView alloc]init];
        _tabBarView.delegate = self;
        _tabBarView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:_tabBarView];
        [self.tabBar addSubview:_tabBarView];
//        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
//        _tabBarView.translatesAutoresizingMaskIntoConstraints = NO;
//        
//        [self.tabBar addConstraints:@[
//                                    
//                                    //view1 constraints
//                                    [NSLayoutConstraint constraintWithItem:_tabBarView
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.tabBar
//                                                                 attribute:NSLayoutAttributeTop
//                                                                multiplier:1.0
//                                                                  constant:0],
//                                    
//                                    [NSLayoutConstraint constraintWithItem:_tabBarView
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.tabBar
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                multiplier:1.0
//                                                                  constant:0],
//                                    
//                                    [NSLayoutConstraint constraintWithItem:_tabBarView
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.tabBar
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1.0
//                                                                  constant:0],
//                                    
//                                    [NSLayoutConstraint constraintWithItem:_tabBarView
//                                                                 attribute:NSLayoutAttributeRight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.tabBar
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:0],
//                                    ]];
        
//        [_tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.right.top.bottom.equalTo(self.tabBar);
//        }];
    }
    return _tabBarView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
    }
    return _lineView;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self prepare];
//    });
    
//    UIView* tw = self.view.subviews[0];//UITransitionView
//    //        tw.backgroundColor = UIColor.grayColor()
//    tw.frame = CGRectMake(0,0,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds) - self.tabBarHeight);
//    
//    CGRect tabBarFrame = self.tabBar.frame;
//    tabBarFrame.size = CGSizeMake(CGRectGetWidth(self.view.bounds), self.tabBarHeight);
//    self.tabBar.frame = tabBarFrame;
    
//    self.tabBarView.frame = self.tabBar.bounds;//CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    self.tabBarView.itemClass = _itemClass;
    self.tabBarView.frame = self.tabBar.bounds;
    [self.tabBar bringSubviewToFront:self.tabBarView];
    self.lineView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1);
    [self.tabBar bringSubviewToFront:self.lineView];
    
    if (changeData) {
        changeData = NO;
        self.tabBarView.dataArray = _dataArray;
        [self ensureControllers];
    }
}

//-(void)prepare{
////    [self.tabBar addSubview:self.tabBarView];
////    [self.tabBar bringSubviewToFront:self.tabBarView];
////    [self.tabBar addSubview:self.lineView];//TODO 添加横线
//}

-(void)ensureControllers{
    NSMutableArray<UIViewController *> *ctrls = [[NSMutableArray alloc] init];
    for (TabData* tabData in _dataArray) {
        [ctrls addObject:tabData.controller];
    }
    [self setViewControllers:ctrls animated:YES];
}

-(void)didSelectItem:(GYTabBarView *)tabBar tabData:(TabData *)tabData index:(NSInteger)index{
    self.selectedIndex = index;
}

-(void)valueCommit:(NSInteger)selectedIndex{
    [self.tabBarView setSelectedIndex:selectedIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.hidden = YES; //直接忽略原先的
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
