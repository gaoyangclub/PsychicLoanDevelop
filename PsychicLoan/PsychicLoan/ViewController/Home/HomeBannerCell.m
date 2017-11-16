//
//  HomeBannerCell.m
//  PsychicLoan
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "HomeBannerCell.h"
#import "SDCycleScrollView.h"

@interface HomeBannerCell()<SDCycleScrollViewDelegate>

@property(nonatomic,retain)SDCycleScrollView *cycleScrollView;

@end


@implementation HomeBannerCell

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 5.0;//间隔5秒轮播
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

//点击选中后回调
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"选中banner index:%ld",(long)index);
}

-(void)showSubviews{
    self.cycleScrollView.frame = self.contentView.bounds;
    self.cycleScrollView.imageURLStringsGroup = self.data;
}

@end
