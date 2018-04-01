
//
//  GYTableViewSection.m
//  GYTableViewController
//
//  Created by 高扬 on 16/10/17.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "GYTableViewSection.h"

@interface GYTableViewSection(){
    
}

@end

@implementation GYTableViewSection

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsLayout];
}

-(void)setSectionIndex:(NSInteger)sectionIndex
{
    _sectionIndex = sectionIndex;
    [self setNeedsLayout];
}

-(void)setData:(NSObject *)data
{
    _data = data;
    [self setNeedsLayout];
}

//-(void)setIsFirst:(BOOL)isFirst{
//    _isFirst = isFirst;
//    [self setNeedsLayout];
//}
//
//-(void)setIsLast:(BOOL)isLast{
//    _isLast = isLast;
//    [self setNeedsLayout];
//}


@end
