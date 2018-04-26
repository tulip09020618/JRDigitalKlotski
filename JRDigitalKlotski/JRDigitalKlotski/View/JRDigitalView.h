//
//  JRDigitalView.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRDigitalModel.h"

// 数字华容道视图中的每个数据模块视图

@interface JRDigitalView : UIView

/**
 数据模块
 */
@property (nonatomic, strong) JRDigitalModel *model;

/**
 想移动
 */
@property (nonatomic, strong) void (^wantToMove) (JRDigitalModel *model);


@end
