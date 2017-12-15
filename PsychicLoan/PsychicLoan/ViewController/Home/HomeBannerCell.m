//
//  HomeBannerCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeBannerCell.h"
#import "SDCycleScrollView.h"
#import "BannerModel.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "AppViewManager.h"
#import "MobClickEventManager.h"

@interface HomeBannerCell()<SDCycleScrollViewDelegate>

@property(nonatomic,retain)SDCycleScrollView *cycleScrollView;

@end


@implementation HomeBannerCell

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 5.0;//间隔5秒轮播
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"banner_line_selected"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"banner_line"];
        _cycleScrollView.pageControlDotSize = CGSizeMake(rpx(20), rpx(20));
        [self.contentView addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

//点击选中后回调
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSArray<BannerModel*>* banners = self.data;
    //跳转到对应的数据id
//    NSLog(@"选中banner index:%ld",(long)index);
    if (index < banners.count) {
        long loanid = banners[index].loanid;
        DetailViewController* viewController = [[DetailViewController alloc]init];
        viewController.loanId = loanid;
        viewController.loanName = banners[index].loanname;
        viewController.hidesBottomBarWhenPushed = YES;
        [[AppViewManager getCurrentNavigationController] pushViewController:viewController animated:YES];
        [MobClickEventManager homeBannerClick:loanid];
    }
}

-(void)showSubviews{
    NSArray<BannerModel*>* banners = self.data;
    NSMutableArray* imageURLStringsGroup = [[NSMutableArray alloc]init];
    for (BannerModel* bannerModel in banners) {
        [imageURLStringsGroup addObject:bannerModel.loanimg];
    }
    self.cycleScrollView.frame = self.contentView.bounds;
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroup;
}

@end
