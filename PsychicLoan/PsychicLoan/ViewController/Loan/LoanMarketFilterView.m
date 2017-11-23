//
//  LoanMarketFilterView.m
//  PsychicLoan
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "LoanMarketFilterView.h"

@interface LoanMarketFilterView()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
    NSArray *_data1;
    NSArray *_data2;
    NSArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
}

@end

@implementation LoanMarketFilterView

-(instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height{
    self = [super initWithOrigin:origin andHeight:height];
    if (self) {
//        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        _data1 = @[@"不限金额",@"0~1000",@"1000~5000",@"5000~10000",@"10000以上"];
        _data2 = @[@"不限资质",@"信用卡",@"芝麻分",@"公积金"];
        _data3 = @[@"不限期限",@"1~30天",@"1月~6月",@"6月~12月",@"12月以上"];
        
        self.selectedTextColor = COLOR_PRIMARY;
        self.normalTextColor = COLOR_TEXT_SECONDARY;
        self.menuFontSize = rpx(14);
        self.itemFontSize = rpx(12);
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 3;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    if (column == 0) {
        return _currentData1Index;
    }
    else if (column == 1) {
        return _currentData2Index;
    }
    else if (column == 2) {
        return _currentData3Index;
    }
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        return _data1.count;
    } else if (column == 1){
        return _data2.count;
    } else if (column == 2){
        return _data3.count;
    }
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    switch (column) {
        case 0: return _data1[_currentData1Index];
            break;
        case 1: return _data2[_currentData2Index];
            break;
        case 2: return _data3[_currentData3Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return _data1[indexPath.row];
    } else if (indexPath.column == 1) {
        return _data2[indexPath.row];
    } else {
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        _currentData1Index = indexPath.row;
    } else if(indexPath.column == 1){
        _currentData2Index = indexPath.row;
    } else{
        _currentData3Index = indexPath.row;
    }
}

@end
