//
//  DetailViewController.h
//  PsychicLoan
//
//  Created by admin on 2017/11/20.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "MJTableViewController.h"

@interface DetailViewController : MJTableViewController

@property(nonatomic,assign)long loanId;
@property(nonatomic,assign)NSString* loanName;

@end
