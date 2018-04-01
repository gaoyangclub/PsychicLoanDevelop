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
        
        _data1 = @[@{@"minamount":@(0),@"maxamount":@(0),@"title":@"不限金额"},
                   @{@"minamount":@(1000),@"maxamount":@(5000),@"title":@"1000~5000"},
                   @{@"minamount":@(5000),@"maxamount":@(10000),@"title":@"5000~10000"},
                   @{@"minamount":@(10000),@"maxamount":@(0),@"title":@"10000以上"}];
        _data2 = @[@{@"search":@(0),@"title":@"不限资质"},
                   @{@"search":@(1),@"title":@"身份证"},
                   @{@"search":@(2),@"title":@"芝麻分"},
                   @{@"search":@(3),@"title":@"信用卡"}];
        _data3 = @[@{@"mintime":@(0),@"maxtime":@(0),@"title":@"不限期限"},
                   @{@"mintime":@(1),@"maxtime":@(30),@"title":@"1~30天"},
                   @{@"mintime":@(30),@"maxtime":@(180),@"title":@"1月~6月"},
                   @{@"mintime":@(180),@"maxtime":@(360),@"title":@"6月~12月"},
                   @{@"mintime":@(360),@"maxtime":@(0),@"title":@"12月以上"},
                   @{@"mintime":@(360),@"maxtime":@(0),@"title":@"13月以上"}
                   ];
        
        self.selectedTextColor = COLOR_PRIMARY;
        self.normalTextColor = COLOR_TEXT_PRIMARY;
        self.menuFontSize = SIZE_TEXT_PRIMARY;
        self.itemFontSize = SIZE_TEXT_SECONDARY;
        
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
        case 0: return [_data1[_currentData1Index] valueForKey:@"title"];
            break;
        case 1: return [_data2[_currentData2Index] valueForKey:@"title"];
            break;
        case 2: return [_data3[_currentData3Index] valueForKey:@"title"];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return [_data1[indexPath.row] valueForKey:@"title"];
    } else if (indexPath.column == 1) {
        return [_data2[indexPath.row] valueForKey:@"title"];
    } else {
        return [_data3[indexPath.row] valueForKey:@"title"];
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
    if (self.filterDelegate && [self.filterDelegate respondsToSelector:@selector(loanFilterSelected:)]) {
        [self.filterDelegate loanFilterSelected:self];
    }
}

-(int)mintime{
    return [[_data3[_currentData3Index] valueForKey:@"mintime"]intValue];
}

-(int)maxtime{
    return [[_data3[_currentData3Index] valueForKey:@"maxtime"]intValue];
}

-(int)search{
    return [[_data2[_currentData2Index] valueForKey:@"search"]intValue];
}

-(int)minamount{
    return [[_data1[_currentData1Index] valueForKey:@"minamount"]intValue];
}

-(int)maxamount{
    return [[_data1[_currentData1Index] valueForKey:@"maxamount"]intValue];
}


@end
