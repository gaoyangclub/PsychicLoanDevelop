//
//  CustomComboboxView.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopListView.h"
#import "FlatButton.h"
#import "GYTableBaseView.h"

@interface PopTableViewCell : GYTableViewCell

@end
@implementation PopTableViewCell

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    self.textLabel.textColor = [UIColor blackColor];//COLOR_BLACK_ORIGINAL;
    self.textLabel.text = GET_CELL_DATA([NSString class]);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end

@interface CustomPopListView()<UITableViewDelegate>

//@property(nonatomic,retain)UIScrollView* scrollView;
@property(nonatomic,retain)GYTableBaseView* tableView;

@end

@implementation CustomPopListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.dataField = @"label";
        self.popFromDirection = CustomPopDirectionBottom;
        self.popToDirection = CustomPopDirectionBottom;
        self.clickItemDismiss = YES;
    }
    return self;
}

-(GYTableBaseView *)tableView{
    if (!_tableView) {
        _tableView = [[GYTableBaseView alloc]initWithFrameAndParams:CGRectZero showHeader:NO showFooter:NO useCellIdentifer:YES topEdgeDiverge:NO];
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc]init];
//        [self.contentView addSubview:_scrollView];
//    }
//    return _scrollView;
//}

-(CGRect)getTableViewFrame{
    return self.contentView.bounds;
}

-(void)viewDidLoad{
    self.tableView.frame = [self getTableViewFrame];
    
//    CGFloat buttonWidth = CGRectGetWidth(self.contentView.bounds);
//    CGFloat buttonHeight = 50;

    Class viewClass;
    if (self.cellClass) {
        viewClass = self.cellClass;
    }else{
        viewClass = [PopTableViewCell class];
    }
    self.tableView.delegate = self;
    __weak __typeof(self) weakSelf = self;
    //为null或者前后时间不一致
    [self.tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSInteger count = strongSelf.dataArray.count;
        for (NSInteger i = 0 ; i < count; i ++) {
            NSObject* data = strongSelf.dataArray[i];
            NSObject* viewData;
            if(viewClass || [data isKindOfClass:[NSString class]]){
                viewData = data;
            }else{
                viewData = [data valueForKey:strongSelf.dataField];
            }
            [svo addCellVo:
             [CellVo initWithParams:50 cellClass:viewClass cellData:viewData]];
        }
    }]];
    [self.tableView reloadGYData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:index:)]){
            [self.delegate onSelectedIndex:self index:indexPath.row];
        }
        if ([self.delegate respondsToSelector:@selector(onSelectedItem:item:)]) {
            [self.delegate  onSelectedItem:self item:self.dataArray[indexPath.row]];
        }
    }
    //    button.tag;
    if (self.clickItemDismiss) {
        [self dismiss];
    }
}

-(void)buttonClick:(UIView*)button{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:index:)]){
            [self.delegate onSelectedIndex:self index:button.tag];
        }
        if ([self.delegate respondsToSelector:@selector(onSelectedItem:item:)]) {
            [self.delegate  onSelectedItem:self item:self.dataArray[button.tag]];
        }
    }
//    button.tag;
    [self dismiss];
}

@end
