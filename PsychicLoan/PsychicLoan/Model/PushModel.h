//
//  PushModel.h
//  PsychicLoan
//
//  Created by 高扬 on 17/12/10.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "BannerModel.h"

@interface PushModel : BannerModel

@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString* pushmessage;

@end
